require 'rails_helper'

RSpec.describe User, type: :model do
  it "saves with all fields valid" do
    @user = User.new(name: "name", email: "test@test.com", password: "abc123321cba", password_confirmation: "abc123321cba")
    expect(@user).to be_valid
  end

  it "does not save when email is missing" do
    @user = User.new(name: "name", email: nil, password: "abc123321cba", password_confirmation: "abc123321cba")
    expect(@user).to_not be_valid
  end

  it "email must be unique, case-insensitively" do
    @user1 = User.new(name: "name", email: "TEST@test.com", password: "abc123321cba", password_confirmation: "abc123321cba")
    @user1.save
    @user2 = User.new(name: "name", email: "test@test.com", password: "abc123321cba", password_confirmation: "abc123321cba")
    @user2.save
    expect(@user2.errors.get(:email)).to eq(['has already been taken'])
  end

  it "does not save when name is missing" do
    @user = User.new(name: nil, email: "test@test.com", password: "abc123321cba", password_confirmation: "abc123321cba")
    expect(@user).to_not be_valid
  end




# use password and password_digest as if they were real fields
  it "saves when password and password_confirmation match" do
    @user = User.new(name: "name", email: "test@test.com", password: "abc123321cba", password_confirmation: "abc123321cba")
    # @result = @user.passwordCheck("banana", "banana")
    @user.save
    expect(@user).to be_truthy
  end

  it "does not save when password and password_confirmation do not match" do
    @user = User.new(name: "name", email: "test@test.com", password: "abc123321cba", password_confirmation: "abc123")
    @user.save
    expect(@user).to_not be_valid
  end

  it "saves when password is > 5" do
    @user = User.new(name: "name", email: "test@test.com", password: "abc123321cba", password_confirmation: "abc123321cba")
    @user.save
    expect(@user).to be_valid
  end

  it "does not saves when password is <= 5" do
    @user = User.new(name: "name", email: "test@test.com", password: "abc", password_confirmation: "abc")
    @user.save
    expect(@user).to_not be_valid
  end
  
  describe '.authenticate_with_credentials' do
    # examples for this class method here
    it "finds valid user when given correct email and password" do
      @user = User.create(name:"captain validpants", email:"valid@pants.com", password: "abc1234", password_confirmation: "abc1234")

      @result = User.authenticate_with_credentials("valid@pants.com", "abc1234")

      expect(@result).to_not be_nil
      expect(@user.id).to eq(@result.id)
    end

    it "finds no user when given incorrect email" do
      User.create(name:"captain validpants", email:"valid@pants.com", password: "abc123321cba", password_confirmation: "abc123321cba")
      # @user = User.find_by_email("check@check.com")
      @user = User.authenticate_with_credentials("wrong@check.com", "notAPassword")
      expect(@user).to be_nil
    end

  end

end
