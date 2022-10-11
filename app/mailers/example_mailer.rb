class ExampleMailer < ApplicationMailer
    default from: "mhuy13660@gmail.com"

    def sample_email85 user
      @user = user
      mail to: @user.email, subject: "Sample Email"
    end

    def post_info(user, post)
        @user = user
        @post = post
        mail to: @user.email, subject: "Post Info"
    end

end
