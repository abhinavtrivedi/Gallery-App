require 'spec_helper'

describe "Authentication Pages" do
  subject {page}
  describe "Given that user visits sign-in" do
    before {visit signin_path}
    it {should have_selector('title', text: 'Sign in')}
    it {should have_selector('h1', text: 'Sign in')}

    describe "when user signs in with invalid data" do
      before {click_button "Sign in"}
      it {should have_selector('div.alert.alert-error', text: 'Invalid')}
      it {should have_selector('title', text: 'Sign in')}

      describe "and after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end

    describe "with valid data" do
      let(:user) {FactoryGirl.create(:user)}
      before { sign_in user }

      it { should have_selector('title', text: user.name) }
      it { should have_link('Profile', href: user_path(user)) }
      it { should have_link('Users', href: users_path) }
      it {should have_link('Setting', href: edit_user_path(user))}
      it { should have_link('Sign out', href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should have_link('Sign in') }
      end
    end
  end

  describe "authorization" do
    describe "for non singed-in users" do
      let(:user) {FactoryGirl.create(:user)}

      describe "in users controller" do

        describe "visiting user index page" do
          before {visit users_path}
          it {should have_selector('title', text: "Sign in")}
        end
      end

      describe "visiting the edit page" do
        before {visit edit_user_path(user)}
        it {should have_selector('title', text: "Sign in")}

        describe "after signing in" do
          before do
            fill_in "Email", with: user.email
            fill_in "Password", with: user.password
            click_button "Sign in"
          end

          it "should render the edit page" do
            page.should have_selector('title', text: 'Edit user')
          end
        end
      end

      describe "submitting update action" do
        before {put user_path(user)}
        specify {response.should redirect_to(signin_path)}
      end
    end

    describe "as wrong user" do
      let(:user) {FactoryGirl.create(:user)}
      let(:wrong_user) {FactoryGirl.create(:user, email: 'wrong@email.com')}
      before {sign_in user}

      describe "visiting User#edit page" do
        before{visit edit_user_path(wrong_user)}
        it {should_not have_selector('title', text: 'Edit user')}
      end
      describe "User#update action" do
        before {put user_path(wrong_user)}
        specify {response.should redirect_to(root_path)}
      end
    end
  end

end
