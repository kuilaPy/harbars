class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact
    eamils = AdminUser::ADMIN_EMAILS
    mail(to: eamils, subject: "New Contact Us Message - Reference ID: #{contact.msg_rf_id}") if eamils.present?
  end
end
