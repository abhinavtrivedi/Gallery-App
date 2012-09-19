require 'spec_helper'

describe "Bid Pages" do

  subject {page}

  let(:bid_link) {'Make a new bid'}
  let(:signin) {'Sign in'}
  let(:bid_button) {'Place my bid'}

  describe "show bid" do
    let(:artifact) {FactoryGirl.create(:artifact)}
    let(:customer) {FactoryGirl.create(:user, name: "John Doe", email: "john@lost.org")}

    describe "without sign-in" do
      before { visit bid_path(artifact)}

      it {should have_selector('title', text: signin)}

    end

    describe "page" do
      before do
        sign_in customer
        visit bid_path(artifact)
      end

      it {should have_selector('title', text: artifact.title)}
      it {should have_selector('h1', text: artifact.title)}
      it {should have_selector('h1', text: artifact.user.name)}
      it {should have_link(bid_link)}
    end

    describe "when no bids have been made" do
      before do
        sign_in customer
        artifact.bid_price = nil
        visit bid_path(artifact)
      end

      it {should have_content('No Bids Recorded yet')}
    end

=begin
    describe "when bid has been made" do
      before do
        sign_in customer
        artifact.bid_price = 120
        visit bid_path(artifact)
      end

      it {should have_content("Current Bid: #{artifact.bid_price}")}
    end
=end

    describe "when artifact owner views bid" do
      before do
        sign_in artifact.user
        visit bid_path(artifact)
      end

      it {should_not have_link(bid_link)}
    end
  end

  describe "make a new bid" do
    let(:artifact) {FactoryGirl.create(:artifact)}
    let(:customer) {FactoryGirl.create(:user, name: "John Doe", email: "john@lost.org")}

    describe "without sign-in" do
      before { visit edit_bid_path(artifact)}

      it {should have_selector('title', text: signin)}
    end

    describe "page" do
      before do
        sign_in customer
        visit edit_bid_path(artifact)
      end

      it {should have_selector('title', text: 'Place your bid')}
      it {should have_selector('h1', text: artifact.title)}
      it {should have_selector('h1', text: artifact.user.name)}
      it {should have_button(bid_button)}
    end

    describe "when no bid entered" do
      before do
        sign_in customer
        visit edit_bid_path(artifact)
        click_button bid_button
      end

      it "artifact bid must not be updated" do
        artifact.bid_price_changed?.should be_false
      end

      it { should have_content('Please enter a bid') }

    end

    describe "when bid value < price" do
      let(:lesser_bid) {artifact.price - 1}
      before do
        sign_in customer
        visit edit_bid_path(artifact)
        fill_in 'Bid price', with: lesser_bid
        click_button bid_button
      end
      let(:new_artifact) {Artifact.find(artifact.id)}
      it "artifact bid must not be updated" do
        new_artifact.bid_price.should_not == lesser_bid
      end

    end

    describe "when correct bid entered" do
      let(:correct_bid) {artifact.price + 1}
      before do
        sign_in customer
        visit edit_bid_path(artifact)
        fill_in 'Bid price', with: correct_bid
        click_button bid_button
      end
      let(:new_artifact) {Artifact.find(artifact.id)}
      it "artifact bid must be updated" do
        new_artifact.bid_price.should == correct_bid
      end
    end
=begin
      describe "less than price" do
        before do
          lesser_bid_price = artifact.price - 1
          fill_in "Bid Price", with: (lesser_bid_price)
          click_button bid_button
        end

        it "artifact bid must not be updated" do
          #new_artifact = Artifact.find(@artifact.id)
          @artifact.bid_price_changed?.should be_false
        end

        it { should have_selector('div.alert.alert-error', text: 'must be higher') }

      end
=end

  end

  describe "edit current bid" do
    let(:customer) {FactoryGirl.create(:user, name: "John Doe", email: "john@lost.org")}
    let(:artifact) {FactoryGirl.create(:artifact, :bid_price => 100, :bid_user_id => customer.id)}

    describe "without sign-in" do
      before { visit edit_bid_path(artifact)}

      it {should have_selector('title', text: signin)}
    end

    describe "page" do
      before do
        sign_in customer
        visit edit_bid_path(artifact)
      end

      it {should have_selector('title', text: 'Place your bid')}
      it {should have_selector('h1', text: artifact.title)}
      it {should have_selector('h1', text: artifact.user.name)}
      it {should have_content("Current Bid: #{artifact.bid_price}")}
      it {should have_button(bid_button)}
    end

    describe "when bid value < current_bid" do
      let(:lesser_bid) {artifact.bid_price - 1}
      before do
        sign_in customer
        visit edit_bid_path(artifact)
        fill_in 'Bid price', with: lesser_bid
        click_button bid_button
      end
      let(:new_artifact) {Artifact.find(artifact.id)}
      it "artifact bid must not be updated" do
        new_artifact.bid_price.should_not == lesser_bid
      end

    end

    describe "when correct bid entered" do
      let(:correct_bid) {artifact.bid_price + 1}
      before do
        sign_in customer
        visit edit_bid_path(artifact)
        fill_in 'Bid price', with: correct_bid
        click_button bid_button
      end
      let(:new_artifact) {Artifact.find(artifact.id)}
      it "artifact bid must be updated" do
        new_artifact.bid_price.should == correct_bid
      end
    end

  end


end
