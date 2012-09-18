require 'spec_helper'

describe "Artifact Pages" do


  subject {page}

  describe "new artifact" do
    let(:user) {FactoryGirl.create(:user)}
    #let(:artifact) {FactoryGirl.create(:artifact)}
    before do

      #artifact.user = user
      #artifact.user_id = user.id
      @artifact = user.artifacts.build(title: "New Artifact",
                                       sample: File.open('spec/support/temp.jpg'),
                                       description: "This a brand new Artifact",
                                       price: 100)

    end



    let(:submit) {"Create new artifact"}

    describe "without signing in" do
      before {visit new_artifact_path}

      it {should have_selector('title', text: 'Sign in')}
    end

    describe "page" do
      before do
        sign_in user
        visit new_artifact_path
      end

      it {should have_link('Sign out')}
      it {should have_selector('title', text: 'New Artifact')}
      it {should have_selector('h1', text: 'Create new Artifact')}

      it {should have_selector('label', text: 'Title')}
      it {should have_field('artifact_title')}

      it {should have_selector('label', text: 'Description')}
      it {should have_field('artifact_description')}

      it {should have_selector('label', text: 'Price')}
      it {should have_field('artifact_price')}

      it {should have_selector('label', text: 'Choose a sample image')}
      it {should have_field('artifact_sample', type: 'file')}

      it {should have_button submit}

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
          fill_in "Title", with: @artifact.title
          fill_in "Description", with: @artifact.description
          fill_in "Price", with: @artifact.price
          attach_file('Choose a sample image', 'spec/support/temp.jpg')
        end

        it "should save artifact" do
          expect {click_button submit}.to change(Artifact, :count)
        end

        describe "after saving artifact" do
          before {click_button submit}
          let(:artifact) {Artifact.find_by_title(@artifact.title)}

          it {should have_selector('title', text: artifact.title)}
          it {should have_selector('h1', text: artifact.title)}
          it {should have_selector('h1', text: artifact.user.name)}
        end
      end
    end








  end

  describe "all artifacts" do
    before { visit artifacts_path }

    it {should have_selector('title', text: 'All Artifacts')}
    it "should list all artifacts" do
      Artifact.all.each do |artifact|
        page.should have_selector('li', text: artifact.title)
      end
    end
  end

  describe "show artifact" do
    let(:artifact) {FactoryGirl.create(:artifact)}
    before do
      visit artifact_path(artifact)
    end

    it {should have_selector('title', text: artifact.title)}
    it {should have_selector('h1', text: artifact.title)}
    it {should have_selector('li', text: artifact.description)}
    it {should have_selector('li', integer: artifact.price)}
    it {should have_selector('h1', text: artifact.user.name)}
    it {should have_selector('img')}

    it {should have_link(artifact.user.name)}
  end
end
