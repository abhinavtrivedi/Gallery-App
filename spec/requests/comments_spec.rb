require 'spec_helper'

describe "Comments" do

  subject {page}

  describe "when user is not signed-in" do
    before do
      @artifact = FactoryGirl.create(:artifact)
      visit artifact_path(@artifact)
    end

    it {should_not have_button 'Post'}
  end

  describe "when user is signed-in" do
    before do
      @artifact = FactoryGirl.create(:artifact)
      sign_in @artifact.user
      visit artifact_path(@artifact)
    end

    it {should have_button 'Post'}
  end

  describe "Post" do
    let(:post) {'Test Post'}
    describe "with empty comment" do
      before do
        @artifact = FactoryGirl.create(:artifact)
        sign_in @artifact.user
        visit artifact_path(@artifact)
      end
    end
  end

end
