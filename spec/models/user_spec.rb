# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "New User", email: "newuser@email.com",
                     password: "password", password_confirmation: "password")
    #@user = User.new(name: "New User", email: "newuser@email.com")
    #@user.password = "test"
    #@user.password_confirmation = "test"

  end

  subject {@user}

  it {should respond_to :name}
  it {should respond_to :email}
  it {should respond_to :password_digest}
  it {should respond_to :password}
  it {should respond_to :password_confirmation}
  it {should respond_to :authenticate}
  it {should respond_to :remember_token}
  it {should respond_to :artifacts}

  it {should be_valid}

  describe "when name is blank" do
    before {@user.name = ""}
    it{should_not be_valid}
  end
  describe "when email is blank" do
    before {@user.email = ""}
    it{should_not be_valid}
  end

  describe "when user email is not unique" do
    before do
      user2 = @user.dup
      user2.email = @user.email.upcase
      user2.save
    end
    it{should_not be_valid}
  end

  describe "when password is not provided" do
    before {@user.password = @user.password_confirmation = ""}
    it {should_not be_valid}
  end

  describe "if password does not match" do
    before {@user.password_confirmation = "test2"}
    it {should_not be_valid}
  end

  describe "authenticate" do
    before {@user.save}
    let(:db_user) { User.find_by_email(@user.email) }

    its(:remember_token) {should_not be_blank}

    describe "with valid password" do
      it { should == db_user.authenticate(@user.password)}
    end
    describe "with invalid password" do
      it "should be false" do
        db_user.authenticate("ba-ba-ba ba-ba nana").should be_false
      end

    end

  end


end
