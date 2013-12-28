require "spec_helper"

describe UserMailer do
  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user) }

=begin
  before do
    sign_in user
    visit user_path(other_user)
    click_button "Follow"
  end

  it { should have_link("Follow", href: following_user_path) }
  it "email user when followed by other user" do
    last_email.to.should include(other.email)
    last_email.subject.should == "New follower"
    last_email.body.should have_content("#{edit_user_path(user)}")
  end
=end
end
