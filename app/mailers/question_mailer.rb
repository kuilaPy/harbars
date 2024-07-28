class QuestionMailer < ApplicationMailer
  # default from: 'notifications@example.com'

  def question_created(question)
    @question = question
    @product = question.product
    @admins = AdminUser.all
    @purchaser = User.where(id: @product.orders.pluck(:user_id).uniq)
    to_emails = @admins.pluck(:email) 

    mail(to: to_emails, subject: 'New Question') if to_emails.present?
  end
end
