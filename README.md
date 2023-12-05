# README

This README has been amended with a proposed documentation and refactoring
effort for the use of JWT authentication.  See System dependencies <TBD>

Things you may want to cover:

* Ruby version  Using Ruby 3.1.2 and Rails 7.0.4.1

* System dependencies
  - JWT Dependency -  Use 2 forms of JWT - one as an Authentication token and one as a refresh token from a Relay Device (phone).
    - UAT is the time limited user auth token.
    - RRT is the permenant relay registration token.
    - Configuration of UAT form - see /config/initializers/devise.rb 
    - Create an RRT_JWT by registering user at relay device ( a phone ).
    - Refresh authentication by calling 'login' with RRT_JWT.
    - Factor out create and check functons for the RRT JWT into RefreshableAuth concern.
      - See /app/controllers/concerns/refreshable_auth.rb 
      - Use "include RefreshableAuth" in:
        -  api/v1/user_relay_registrations.rb and 
        -  api/v1/auth_sessions_controller.rb

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
