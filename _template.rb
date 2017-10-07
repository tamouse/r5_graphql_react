# A rails template to build this app
# See: http://guides.rubyonrails.org/rails_application_templates.html
#
# Use the following command:
#
# rails new Path/To/app \
#   --template=_template.rb \
#   -rc=_template.rc

app_name = File.basename(Dir.pwd)
say "Creating #{app_name}"

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
gem 'foreman', '~> 0.82.0'
gem 'graphql'
gem 'json_web_token'

gem_group :development, :test do
  gem 'byebug'
  gem 'rspec-rails'
  gem 'pry-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'timecop'
end

gem_group :development do
  gem 'listen'
end

run "bundle install"
generate 'rspec:install'
generate 'graphql:install'
run "bundle install"

initializer 'uuid_generator.rb', <<-CODE
require "uuid"

# See https://github.com/assaf/uuid#uuid-state-file
UUID.state_file = false
UUID.generator.next_sequence

CODE

rakefile "start.rake" do
  %Q{
desc "Start both Rails API and Webpack Dev servers"
task :start do
  exec "foreman start -p 3000"
end
}
end

file "Procfile" do
  %Q{
web: cd client && npm start
api: bundle exec rails server -p 3001
}
end
# TODO: Remember to add proxy to client/package.json later

directory 'app'

generate :model, 'User', 'uuid:uniq', 'name', 'email:uniq', 'password_digest', 'admin:boolean', '--skip-test', '--skip-factory'
insert_into_file 'app/models/user.rb', after: "class User < ApplicationRecord\n" do
  %Q|
  include EnsureUUID

  has_secure_password

  validates_presence_of :name, :email, :password_digest
  validates_uniqueness_of  :email

|
end

run "rm spec/factories/users.rb"
run "rm spec/models/user_spec.rb"
directory 'spec'

prepend_to_file 'README.md', <<-INFO

# Rails API application: `#{app_name}`

Here's what's included:

- Postgres database
- Rspec tests, with Factory Girl and Faker
- Pry in rails console
- GraphQL and GraphiQL

### Features

- UUID model concern, to add uuid's to all models to be exposed through GraphQL
- JSON Web Token authentication

### Additions

- User model in `app/models/user` with the following:
  - password digest secured by bcrypt
  - `:name` field
  - unique `:email` field
  - unique `:uuid` field
  - `:admin` boolean

INFO

##### REACT APP
run "create-react-app client"
inside "client" do
  inject_into_file 'package.json', after: /^{/ do
    %Q{
  "proxy": "http://localhost:3001",

}
  end

  run "npm install --save lodash recompose"
  run "npm install --save react-router react-router-dom"
  run "npm install --save react-apollo"
  run "npm install --save-dev enzyme enzyme-to-json"
  run "npm install --save-dev graphql@0.10.0 graphql-tools"
  run "npm install --save-dev apollo-test-utils"
end

rails_command "db:create"
rails_command "db:migrate"

git :init
git add: "."
git commit: %q{ -m "Initial Commit" }
git :status

rails_command "spec"



say %Q|

********************************************************************************

Welcome to your new Rails API + GraphQL + React applicaiton

********************************************************************************

Cd into the app directory, #{Dir.pwd} and start coding!

You may want to install https://github.com/skevy/graphiql-app if you haven't to
have a nice interface to your graphql api.

|
