require "spec_helper"

describe UserMailer do
  let(:user) { FactoryGirl.create(:user) }

  subject { page }

  before do
    #sign_in user
    #visit user_path(other_user)
    #click_button "Follow"
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.perform_deliveries = true
    UserMailer.new_follower_notification(user).deliver
  end

  it "should send a email" do
    ActionMailer::Base.deliveries.count.should == 1
  end

  it "renders the receiver email" do
    last_email.to.should == [user.email]
  end

  it "renders the sender email" do
    last_email.from.should == ['sunwiner@yeah.net']
  end

  it "render the subject" do
    last_email.subject.should == "New follower"
  end

  it "assigns @name" do
    last_email.body.encoded.should match(user.nickname)
  end
end
