# Rails5 + GraphQL + React Sample App with JWT auth


![rails](https://img.shields.io/badge/server-rails-red.svg)
![graphql](https://img.shields.io/badge/api-graphql-663399.svg)
![react](https://img.shields.io/badge/client-react-blue.svg)
![travis](https://img.shields.io/travis/tamouse/r5_graphql_react.svg)


This is a sample app I'm building to play around with and learn using
Rails5 API features, GraphQL, and working with a completely separate
React front-end client.

I'm not using any of the webpacker or webpack-rails features, making
this a pure Rails API and a pure React client.

## What's included

- Postgres database
- JSON Web Token authentication
- UUIDs for database objects
- Rails application template, including template files and rc file


## TODOs:

- [ ] create mutations for the authorization part (create user, login,
  logout, etc)
- [ ] set up Pundit for authorization stuff
- [ ] create the React + Apollo client
- [ ] handle login, logout, token refresh, etc, in React app
