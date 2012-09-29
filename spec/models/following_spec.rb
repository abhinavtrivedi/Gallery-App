require 'spec_helper'

describe Following do

  let(:follower) {FactoryGirl.create(:user)}
  let(:followed) {FactoryGirl.create(:user)}
  let(:following) { follower.followings.build(followed_id: followed.id) }

  subject {following}

  its(:follower_id) {should == follower.id}
  its(:followed_id) {should == followed.id}
  it {should be_valid}

  describe "followers" do
    it {should respond_to(:follower)}
    it {should respond_to(:followed)}
  end

  describe "when follower id is not present" do
    before {following.follower_id = nil}

    it {should_not be_valid}
  end

  describe "when followed id is not present" do
    before {following.followed_id = nil}

    it {should_not be_valid}
  end
end
