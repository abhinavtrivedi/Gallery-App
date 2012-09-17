require 'spec_helper'

describe "Artifact Pages" do

  subject {page}

  describe "create new artifact" do
    let(:user) {FactoryGirl.create(:user)}
    before {visit new_artifact_path}
    #before {sign_in user }

    it {should have_selector('title', text: 'New Artifact')}
    it {should have_selector('h1', text: 'Create new Artifact')}
    it {should have_button("Create new artifact")}

    let(:submit) {"Create new artifact"}
    describe "with no content" do
      it "should not save artifact" do
        expect {click_button submit}.not_to change(Artifact, :count)
      end
    end

    describe "with valid content" do
      before do
        fill_in "Title", with: "My New Artifact"
      end

      it "should save artifact" do
        expect {click_button submit}.to change(Artifact, :count)
      end
    end
  end
end
