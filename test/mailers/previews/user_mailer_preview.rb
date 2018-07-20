class UserMailerPreview < ActionMailer::Preview
  def order_email
    UserMailer.order_email
  end
end