class ApplicationMailer < ActionMailer::Base
  before_action :set_user_email

  default from: -> { @sender }
  layout "mailer"

  private 
  
  def set_user_email
    @sender = "ahihi@mail.com"
    # @sender = current_user? ? current_user.email : User.first.email

    # if user_signed_in? 
    #   @sender = current_user.email
    # else 
    #   @sender = User.first.email
    # end 
  end

end
