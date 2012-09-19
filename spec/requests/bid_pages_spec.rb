require 'spec_helper'

describe "Bid Pages" do


  subject {page}

  let(:bid_link) {'Make a new bid'}
  let(:signin) {'Sign in'}

  describe "show bid page" do
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

    describe "when bid has been made" do
      before do
        sign_in customer
        artifact.bid_price = 120
        visit bid_path(artifact)
      end

      it {should have_content("Current Bid: #{artifact.bid_price}")}
    end

    describe "when artifact owner views bid" do
      before do
        sign_in artifact.user
        visit bid_path(artifact)
      end

      it {should_not have_link(bid_link)}
    end
  end
end
