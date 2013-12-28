require 'spec_helper'

describe "password resets page" do
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}
  let!(:user) { FactoryGirl.create(:user) }
  subject { page }

  describe "password reset submit page" do
    before { visit new_password_reset_path }

    describe "have content" do
      it { should have_selector('title', text: "Reset password") }
      it { should have_selector('h1', text: "Reset password") }
      it { should have_link("Sign up", href: signup_path) }
      it { should have_link("Sign in", href: signin_path) }
    end

    describe "click signup link" do
      before { click_link "Sign up" }
      it { should have_selector('title'), text: "Sign up" }
    end

    describe "with invalid/non-exist email" do
      before do
        fill_in "Email", with: "aaa@examp.com"
        click_button "Reset password"
      end

      it { should have_selector('div.alert.alert-error', text: "Please provide correct email") }
    end

    # omit valid email tests for now since it makes test run too slow
=begin
  describe "with valid/exist email" do
    before do
      fill_in "Email", with: user.email
      click_button "Reset password"
    end

    it { should have_selector('div.alert.alert-notice', text: "Password reset email sent") }
  end
=end
  end

  describe "update password page" do
    before { visit edit_password_reset_path(user.password_reset_token) }

    it { should have_selector('title', text: "Reset password") }
    it { should have_selector('h1', text: "Reset password") }

    describe "with password too short" do
      before { update_password("foo", "foo") }

      it { should have_selector('div.alert.alert-error') }
    end

    describe "with password not match" do
      before { update_password("foobar", "foo") }

      it { should have_selector('div.alert.alert-error') }
    end

    describe "with valid password" do
      before { update_password("foobar", "foobar") }

      it { should have_selector('div.alert.alert-notice', text: "Password has been reset.") }
      # should redirect to homepage
      it { should have_selector('title', text: full_title('')) }
      it { should have_link("Sign out", href: signout_path) }
    end
  end
end
