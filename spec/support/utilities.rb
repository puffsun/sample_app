
include ApplicationHelper

def sign_in(user)
  visit signin_path
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
  # Sign in when not using Capybara as well
  cookies[:remember_token] = user.remember_token
end

def update_password(pass, pass_confirm)
  fill_in "Password", with: pass
  fill_in "Password confirmation", with: pass_confirm
  click_button "Update password"
end
