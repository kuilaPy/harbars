# Preview all emails at http://localhost:3000/rails/mailers/question_mailer
class QuestionMailerPreview < ActionMailer::Preview
  def send_question_notifications
    q = Question.last
    QuestionMailer.question_created(q)
  end
end
