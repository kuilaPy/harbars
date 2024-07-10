class Order < ApplicationRecord
  include AASM
  enum shipping_mode: {cash: 1, online: 2}
  enum status: {initiate: 1, processed: 2, shipped: 3, delivered: 4, returned: 5, cancelled: 6}

  has_many :order_items
  has_many :products, through: :order_items
  belongs_to :payment, optional: true
  belongs_to :user
  belongs_to :shipping_address, class_name: "Address", foreign_key: "shipping_address_id"
  belongs_to :billing_address, class_name: "Address", foreign_key: "billing_address_id"

  before_validation :set_order_reference

  PICKUP_LOCATION = {
    "name": "chandra-herbals",
    "add": "NOHAR, WARD NO 05, VILLAGE CHAK DEIDASPURA",
    "city": "NOHAR",
    "pin_code": "335523",
    "country": "India",
    "phone": "9609235365"
  }

  aasm column: 'status', enum: true do
    state :initiate, initial: true
    state :processed, after_enter: :initiate_order_with_partner
    state :shipped, after_enter: :update_delivery_cost
    state :delivered
    state :returned
    state :cancelled

    event :processing do
      transitions from: :initiate, to: :processed
    end

    event :shipping do
      transitions from: :processed, to: :shipped
    end

    event :deliver do
      transitions from: :shipped, to: :delivered
    end

    event :return do
      transitions from: :delivered, to: :return
    end

    event :cancel do
      transitions from: [:processing, :shipping], to: :cancelled
    end
  end

  def get_expect_delivery_date
    self.reload
  end

  def initiate_order_with_partner
    body_params = {
      pickup_location: PICKUP_LOCATION,
      shipments: [
        {
          "name": shipping_address.name,
          "add": "#{shipping_address.address_line_1} #{shipping_address.address_line_2}",
          "pin": shipping_address.zip_code,
          "city": shipping_address.city,
          "state": shipping_address.state,
          "country": "India",
          "phone": shipping_address.contact_number,
          "order": self.order_reference,
          "payment_mode": "Prepaid",
          "return_pin": "",
          "return_city": "",
          "return_phone": "",
          "return_add": "",
          "return_state": "",
          "return_country": "",
          "products_desc": "",
          "hsn_code": "",
          "cod_amount": "0",
          "order_date": nil,
          "total_amount": (total_price / 1000).to_s,
          "seller_add": PICKUP_LOCATION['pin_code'],
          "seller_name": "Avijit Kuilla",
          "seller_inv": "",
          "quantity": "1",
          "waybill": "",
          "shipment_width": "100",
          "shipment_height": "100",
          "weight": "100",
          "seller_gst_tin": "08BGCPK6340Q2ZX",
          "shipping_mode": "Surface",
          "address_type": shipping_address.address_type
        }
      ]
    }
    res = DeliveryPartner.create_shipment body_params
    if res.present? && res["success"]
    else
      errors.add(:base, "Not able to create pickup request on delivery partner")
      raise ActiveRecord::Rollback
    end
  end

  def update_delivery_cost
    res = DeliveryPartner.get_delivery_cost shipping_address.zip_code, 100
    puts res
    self.update(delivery_cost: res)
  end

  private 

  def set_order_reference
    return if order_reference.present?
    begin
      self.order_reference = _key = generate_key
    end while self.class.exists?(order_reference: _key)
  end

  def generate_key
    SecureRandom.hex[0...16]
  end
  
end
