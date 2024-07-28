class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      respond_to do |format|
        format.turbo_stream 
        format.html { redirect_to new_contact_path, notice: "Your message has been sent." }
      end
    else
      respond_to do |format|
        format.turbo_stream
        format.html { render :new, alert: "There was an error sending your message." }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message, :msg_rf_id)
  end
end
