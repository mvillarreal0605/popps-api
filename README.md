# README

This README has been amended with a proposed documentation and refactoring
effort for the use of JWT authentication.  See System dependencies <TBD>

Things you may want to cover:

* Ruby version  Using Ruby 3.1.2 and Rails 7.0.4.1

* System dependencies
  - JWT Dependency -  <TBD> Need explination of JWT use and configuration.
    - Two forms of JWT - UAT (user auth token) and RRT (relay registration token)
    - Configuration of UAT form - see /config/initializers/devise.rb 
    - Create an RRT_JWT by registering user at relay device ( a phone ).
    - Refresh authentication by calling 'login' with RRT_JWT.
    - Factor out create and check functons for the RRT JWT into (e.g.) Refreshable concern.
      - currently see:
        -  api/v1/user_relay_registrations.rb and 
        -  api/v1/auth_sessions_controller.rb

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
