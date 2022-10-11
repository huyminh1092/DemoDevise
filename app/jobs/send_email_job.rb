class SendEmailJob < ApplicationJob
  queue_as :default

  def perform user
    # Do something later
    @user = user
    ExampleMailer.post_info(@user).deliver_later
  end
end
