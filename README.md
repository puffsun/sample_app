# Ruby on Rails sample project: sample application

This is the sample application for
[*Ruby on Rails*], which I'm learning on
by [George Sun]

Rails 3.2.3
ruby 1.9.3p484 (2013-11-22 revision 43786) [x86_64-darwin13.0.0]

It's a complete project following the book: Ruby on Rails tutorial 2nd edition,
with all of exercise finished. Also it add the extension features:

- [x] Twitter flavored replies - prefix twits with @nickname
- [x] User's unique nickname, - to support twits reply
- [ ] Direct private messaging
- [x] Follower notification - the problem of current implementation is that I used <del>synchronous</del> call to ActionMailer, will solve this problem with asynchronous call after upgrading to rails 4 above.
- [x] Password reminders - to support password reset
- [ ] Signup confirmation - ask user to verify the login email before activating the account
- [ ] RSS feed
- [ ] REST API - expose APIs for third-party applicatoins
- [ ] Search support

You may find this codebase helpful if you encounter any problem during learning the book [http://ruby.railstutorial.org/ruby-on-rails-tutorial-book], so enjoy rails.
