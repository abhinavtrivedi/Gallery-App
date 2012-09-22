require 'spec_helper'

describe "Comments" do

  subject {page}

=begin
  describe "when user is not signed-in" do
    before do
      @artifact = FactoryGirl.create(:artifact)
      visit artifact_path(@artifact)
    end

    it {should_not have_button 'Post'}
  end
=end

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

      it "should not save the comment" do
        expect {click_button 'Post'}.not_to change(Comment, :count)
      end
    end

    describe "with valid comment" do
      before do
        @artifact = FactoryGirl.create(:artifact)
        sign_in @artifact.user
        visit artifact_path(@artifact)

        fill_in 'comment_comment_text', with: post
      end

      it "should save the comment" do
        expect {click_button 'Post'}.to change(Comment, :count).by(1)
      end


    end

  end

end
