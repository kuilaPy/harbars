class Payment < ApplicationRecord
  include AASM
  enum payment_method: {cod: 1, online: 2}
  enum status: {pending: 1, authorized: 2, captured: 3, error: 4}
  has_one :order
  belongs_to :user
  belongs_to :cart, optional: true
  before_validation :set_payment_reference
  after_create :create_razorpay_order

  # define aasm state for column status
  aasm column: 'status', enum: true do
    state :pending, initial: true
    state :authorized, after_enter: :capture_payment
    state :captured, after_enter: :should_complete_transaction?
    state :error

    event :authorize do
      transitions from: :pending, to: :authorized
    end

    event :capture do
      transitions from: :authorized, to: :captured
    end

    event :invalidate do
      transitions from: [:pending, :authorized, :captured], to: :error
    end
  end

    # Creates a Razorpay order if the payment method is "online" by calling Razorpay::Order.create with the specified amount, currency, and receipt. Updates the model columns with the Razorpay order ID if the order is successfully created.
  def create_razorpay_order
    if payment_method == "online"
      raj_order = Razorpay::Order.create({
        amount: (self.amount.to_f.round(2) * 100).to_i,
        currency: "INR",
        receipt: payment_reference 
      })
      self.update_columns(razorpay_order_id: raj_order.id)
    end
  end

  # Checks if the transaction should be completed based on the current state.
  def should_complete_transaction?
    if self.captured?
      user = self.user
      cart = Cart.find_by(external_user_id: user.external_user_id)
      order = Order.create(payment_id: self.id, user: user, status: 'initiate', total_price: cart.total_price, total_with_gst: cart.total_price * 1.18, shipping_address_id: user.default_address.id, billing_address_id: user.default_address.id)
      cart.cart_items.each do |item|
        order.order_items.create(product_id: item.product_id, quantity: item.quantity, price: item.price)
      end
      cart.update_columns(status: false)
    end
  end

  def fetch_payment(raz_payment_id)
    Razorpay::Payment.fetch(raz_payment_id)
  end

  def capture_payment
    razorpay_payment = fetch_payment(self.razorpay_payment_id)
    if razorpay_payment.status == "authorized"
      # razorpay_payment.capture({ amount: 10000 })
      razorpay_payment.capture({ amount: (self.amount.to_f.round(2) * 100).to_i })
      self.capture!
      self.touch(:captured_at)
    elsif razorpay_payment.status == "captured"
      self.capture!
      self.touch(:captured_at)
    else
      self.invalidate!
      update(remarks: "Unable to 'capture' payment as Razorpay payment is not in 'authorized' state. Current Razorpay status is: #{razorpay_payment.status}.")
    end
  end
    

  private 

  def set_payment_reference
    return if payment_reference.present?
    begin
      self.payment_reference = _key = generate_key
    end while self.class.exists?(payment_reference: _key)
  end

  def generate_key
    SecureRandom.hex[0...16]
  end
end
