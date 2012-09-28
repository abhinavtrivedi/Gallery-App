require 'spec_helper'

describe Following do

  let(:follower) {FactoryGirl.create(:user)}
  let(:followed) {FactoryGirl.create(:user, email: 'foo@bar.com')}
  let(:following) {follower.followings.build(followed_id: followed.id)}

  subject{following}

  it {should be_valid}

  describe "followers" do
    it {should respond_to(:follower)}
    it {should respond_to(:followed)}
  end

  describe "when follower id is not present" do

  end
end
