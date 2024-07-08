class Address < ApplicationRecord
  enum address_type: {home: 1, office: 2, other: 3}
  belongs_to :user
  has_many :shipping_orders, class_name: "Order", foreign_key: "shipping_address_id"
  has_many :billing_orders, class_name: "Order", foreign_key: "billing_address_id"

  validates_presence_of :name, :address_line_1, :contact_number, :zip_code
  validates_format_of :contact_number, :with => /[0-9]{9}/
  validates_length_of :contact_number, is: 10,  message: "Number must be 10 digit long"
  validates_length_of :zip_code, is: 6,  message: "Number must be 6 digit long"

  after_save :set_default
  scope :default, -> { where(is_default: true)}
  
  private

  def set_default
    self.user.addresses.update_all(is_default: false)
    self.update_columns(is_default: true)
  end
end
