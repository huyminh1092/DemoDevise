class PostMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.post_mailer.creation_email.subject
  #
  default from: 'mhuy13660@gmail.com'

  # def creation_email(post, user)
  #   @post = post
  #   @user = user
  #   mail to: @user.email, subject: "Hello World"
  # end

  # def send_image(post, user, filename, path)
  #   @post = post
  #   @user = user
  #   attachments[filename.to_s] = File.read(path)
  #   mail to: @user.email, subject: "Hello world and world"
  # end

  def send_image(post, user, avatar, images, files)  
    @post = post
    @user = user
    attachments[avatar.to_s] = File.read("#{@post.avatar_path}")
    images.each do |image|    
      attachments[image.filename.to_s] = File.read("#{@post.attachment_path(image)}")
    end
    files.each do |file|
      attachments[file.filename.to_s] = File.read("#{@post.attachment_path(file)}")
    end
    mail to: @user.email, subject: "Hello world and world"
  end

  

  def welcome(user, filename, path)
    attachments[filename] = File.read(path)
    mail(:to => user.email, :subject => "New account information")
  end

#  UserMailer.welcome(user, filename, path).deliver
end
