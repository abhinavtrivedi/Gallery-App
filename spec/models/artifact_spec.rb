require 'spec_helper'

describe Artifact do
  let(:user) {FactoryGirl.create(:user)}
  before do
    @artifact = user.artifacts.build(title: "New Artifact")
  end

  subject{@artifact}

  it {should respond_to(:title)}
  it {should respond_to(:user_id)}
  it {should respond_to(:user)}
  its(:user) { should == user}

  it {should be_valid}

  describe "without title" do
    before {@artifact.title = nil}
    it {should_not be_valid}
  end

=begin
  describe "without artist_id" do
    before {@artifact.user_id = nil}
    it {should_not be_valid}
  end
=end

  describe "accessible attributes" do
    it "should not allow access to artist_id" do
      expect do
        Artifact.new(artist_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end
end