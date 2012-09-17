require 'spec_helper'

describe "Artifact Pages" do

  subject {page}

  describe "New artifact" do
    let(:user) {FactoryGirl.create(:user)}
    let(:artifact) {FactoryGirl.create(:artifact)}
    before {visit new_artifact_path}
    #before {sign_in user }
    let(:submit) {"Create new artifact"}

    describe "page" do
      it {should have_selector('title', text: 'New Artifact')}
      it {should have_selector('h1', text: 'Create new Artifact')}
      it {should have_selector('label', text: 'Title')}
      it {should have_field('artifact_title')}
      it {should have_selector('label', text: 'Choose a sample image')}
      it {should have_field('artifact_sample', type: 'file')}
      it {should have_button submit}
    end

    describe "with no content" do
      it "should not save artifact" do
        expect {click_button submit}.not_to change(Artifact, :count)
      end
    end

    describe "with no sample image" do
      it "should not save artifact" do
        expect {click_button submit}.not_to change(Artifact, :count)
      end
    end

    describe "with valid content" do
      before do
        fill_in "Title", with: "My New Artifact"
        attach_file('Choose a sample image', 'spec/support/temp.jpg')
      end

      it "should save artifact" do
        expect {click_button submit}.to change(Artifact, :count)
      end

      describe "after saving artifact" do
        before {click_button submit}
        let(:artifact) {Artifact.find_by_title("My New Artifact")}

        it {should have_selector('title', text: artifact.title)}
      end
    end
  end

  describe "All Artifacts" do
    before { visit artifacts_path }

    it {should have_selector('title', text: 'All Artifacts')}
    it "should list all artifacts" do
      Artifact.all.each do |artifact|
        page.should have_selector('li', text: artifact.title)
      end
    end
  end
end
