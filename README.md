# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version - ruby-2.6.3
* Rails version - Rails 5.0.7.2

* System dependencies

* Configuration

* Database creation

	default: &default
	  adapter: mysql2
	  encoding: utf8
	  pool: 5
	  username: root
	  password:

	development:
	  <<: *default
	  database: nylas_demo_development
	test:
	  <<: *default
	  database: nylas_demo_test

	production:
	  <<: *default
	  database: nylas_demo_production


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

	 rails new nylas_demo
	 cd nylas_demo
	 rvm current
	 bundle install
	 rails generate bootstrap:install static

	rails g scaffold User name:string image:string email:string connected_email:string refresh_token:string email_connection_date:datetime uid:string email_provider:string

	rails g scaffold Mail mail_id:string raw_email:text from:string mail_date:string



	rails g bootstrap:themed Users
	rails g bootstrap:themed Mails
	rake db:create
	rake db:migrate
