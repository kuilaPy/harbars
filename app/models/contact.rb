class Contact < ApplicationRecord
  before_create :generate_msg_rf_id
  after_create :send_mail



 
  def send_mail
    ContactMailer.contact_email(self).deliver_later
  end

  private

  def generate_msg_rf_id
    today = Date.today.strftime("%Y%m%d")  # Format the date as YYYYMMDD
    self.msg_rf_id = loop do
      random_id = "#{today}-#{SecureRandom.alphanumeric(6).upcase}"
      break random_id unless Contact.exists?(msg_rf_id: random_id)
    end
  end
end
