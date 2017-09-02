# A rails template to build this app
# See: http://guides.rubyonrails.org/rails_application_templates.html
#
# Use the following command:
#
# rails new Path/To/app \
#   --template=__FILE__ \
#   --database=postgresql \
#   --api \
#   --skip-yarn \
#   --skip-gemfile \
#   --skip-sprockets \
#   --skip-spring \
#   --skip-coffee \
#   --skip-javascript \
#   --skip-turbolinks \
#   --skip-test \
#   --skip-system-test \
#   --skip-bundle

run 'touch Gemfile'
def source_paths
  [File.expand_path('../_templates/', __FILE__)]
end

add_source 'https://rubygems.org'
gem 'rails'
gem 'pg'
gem 'puma'
gem 'bcrypt'
gem 'rack-cors'
gem 'uuid'
gem 'graphql'
gem 'graphiql-rails'
gem 'json_web_token'

gem_group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'factory_girl_rails'
  gem 'faker'
end

gem_group :development do
  gem 'listen'
end

initializer 'uuid_generator.rb', <<-CODE
require "uuid"

# See https://github.com/assaf/uuid#uuid-state-file
UUID.state_file = false
UUID.generator.next_sequence

CODE

directory 'app'

generate :model, 'User', 'uuid:uniq', 'name', 'email:uniq', 'password_digest'
insert_into_file 'app/models/user.rb', after: "class User < ApplicationRecord\n" do
  %Q|
  include EnsureUUID

  has_secure_password

  validates_presence_of :name, :email, :password_digest
  validates_uniquenes_of  :email

|
end

generate 'rspec:install'


run "bundle install"
run 'git init'
run 'git status'
