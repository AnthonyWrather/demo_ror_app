# Preview all emails at http://localhost:3000/rails/mailers/urgent_task_mailer
class UrgentTaskMailerPreview < ActionMailer::Preview
  def urgent_task
    UrgentTaskMailer.with(recipient: User.first, record: Task.first).urgent_task
  end
end
