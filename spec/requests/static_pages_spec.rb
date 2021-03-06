require 'spec_helper'

describe "Static pages" do
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_selector('title', text: full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading) { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_selector('title', :text => '| Home') }

    it "should have the right links on the layout" do
      visit root_path
      click_link "About"
      page.should have_selector 'title', text: full_title('About Us')
      click_link "Help"
      page.should have_selector 'title', text: full_title('Help')
      click_link "Home"
      page.should have_selector 'title', text: full_title('')
      click_link "Sign up now!"
      page.should have_selector 'title', text: full_title("Sign up")
      click_link "sample app"
      page.should have_selector 'title', text: full_title("")
    end

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end
=begin
      describe "micropost character count lower than 140" do
        before { fill_in "micropost_content", with: "abc" }
        it { should have_content("137 characters remaining") }
      end

      describe "micropost character count higher than 140" do
        before { fill_in "micropost_content", with: 'a' * 150 }
        it { should have_content("-10 characters remaining") }
      end
=end
      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 following", href: following_user_path(user)) }
        it { should have_link("1 followers", href: followers_user_path(user)) }
      end

      describe "in reply to" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          fill_in 'micropost_content', with: "@#{other_user.nickname}"
          click_button "Post"
          click_link "Sign out"
          sign_in other_user
          visit root_path
        end

        it { should have_content("@#{other_user.nickname}") }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading) { 'Help' }
    let(:page_title) { "Help" }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading) { 'About Us' }
    let(:page_title) { "About Us" }

    it_should_behave_like "all static pages"
  end

  describe "Contact page" do
    before { visit contact_path }
    let(:heading) { 'Contact' }
    let(:page_title) { "Contact" }

    it_should_behave_like "all static pages"
  end
end
