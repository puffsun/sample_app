require 'spec_helper'

describe "Micropost pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do
      it "should not create a micropost" do
        expect { click_button "Post" }.should_not change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end

      describe "with valid information" do
        before { fill_in 'micropost_content', with: "Lorem ipsum" }
        it "should create a micropost" do
          expect { click_button "Post" }.should change(Micropost, :count).by(1)
        end

        describe "microposts count" do
          before do
            FactoryGirl.create(:micropost, user: user)
            visit root_path
          end
          it { should have_content("1 micropost") }

          describe "add one more micropost" do
            before do
              FactoryGirl.create(:micropost, user: user)
              visit root_path
            end
            it { should have_content("2 microposts") }
          end
        end
      end
    end
  end

  describe "pagination" do
    before { visit root_path }
    before(:all) { 33.times { FactoryGirl.create(:micropost, user: user) } }
    after(:all) { Micropost.delete_all }

    let(:first_page) { Micropost.paginate(page:1) }
    let(:second_page) { Micropost.paginate(page:2) }

    it { should have_link("Next") }
    it { should have_selector('div.pagination') }
    its(:html) { should match('>2</a>') }

    it "should list each micropost" do
      Micropost.paginate(page: 1).each do |micropost|
        page.should have_selector('li', text: micropost.content)
      end
    end
  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it { should have_link('delete') }
      it "should delete a micropost" do
        expect { click_link "delete" }.should change(Micropost, :count).by(-1)
      end
    end
  end
end
