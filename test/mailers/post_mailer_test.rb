require "test_helper"

class PostMailerTest < ActionMailer::TestCase
  test "creation_email" do
    mail = PostMailer.creation_email
    assert_equal "Creation email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
