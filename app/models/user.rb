class User < ActiveRecord::Base
  has_secure_password
  has_many :reviews

  def self.authenticate_with_credentials(email_address, password)
    check_user = User.find_by_email(email_address)
    if check_user && check_user.authenticate(password)
      return check_user
    else
      return nil
    end
  end

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :password, length: { minimum: 5 }

end
