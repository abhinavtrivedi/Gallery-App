require 'spec_helper'

describe "User Pages" do

  subject {page}

  describe "Index Page" do
    before do
      sign_in FactoryGirl.create(:user)
      FactoryGirl.create(:user, name:"Fred Durst", email:"fred@metallica.com")
      FactoryGirl.create(:user, name:"John Lenon", email:"john@be.cool")
      visit users_path
    end

    it {should have_selector('title', text: "Users")}
    it "should list each user" do
      User.all.each do |user|
        page.should have_selector('li', text: user.name)
      end
    end
  end

  describe "Signup Page" do
    before { visit signup_path }
    it {should have_selector('h1', text: 'Sign Up')}
    it {should have_selector('title', text: 'Sign Up')}

    let(:submit) { "Create my account" }
    describe "with invalid details" do
      it "should not create user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid details" do
      before do
        fill_in "Name", with: "Jim Morrison"
        fill_in "Email", with: "jim@roadhouse-blues.com"
        fill_in "Password", with: "morrison"
        fill_in "Confirm Password", with: "morrison"
      end
      it "should create user" do
        expect {click_button submit}.to change(User, :count).by(1)
      end
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by_email('jim@roadhouse-blues.com') }

        it { should have_selector('title', text: user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        it { should have_link('Sign out') }
      end
    end

  end

  describe "Profile page" do
    let(:user) {FactoryGirl.create(:user)}
    before { visit user_path(user) }
    it { should have_selector('title', text: user.name) }
  end

  describe "edit Profile" do
    let(:user) {FactoryGirl.create(:user)}
    before {sign_in user}
    before {visit edit_user_path(user)}

    describe "page" do
      it {should have_selector('h1', text: 'Update your profile')}
      it {should have_selector('title', text: 'Edit user')}
      it {should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid content" do
      before {click_button "Save Changes"}

      it {should have_content('error')}
    end

    describe "with valid content" do
      let(:new_name) {"New Name"}
      let(:new_email) {"new@email.com"}
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save Changes"
      end

      it {should have_selector('title', text: new_name)}
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }

    end

  end


end
