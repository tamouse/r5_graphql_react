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
- React+Apollo client supporting sign up, login, and logout with JWTs

## TODOs:

- [X] create mutations for the authorization part (create user, login,
  logout, etc)
- [ ] set up Pundit for authorization stuff
- [X] create the React + Apollo client
- [X] handle login, logout, token refresh, etc, in React app
- [ ] add pagination for collections
- [ ] document *everything*

## Running the app

There is a rake task to make starting the app in dev easy:

    rake start

This starts up both the rails server running on port 3001 and the
webpack-dev-server running on port 3000. The webpack-dev-server
proxies requests to the rails server via an entry in `package.json`:

```json
  "proxy": "http://localhost:3001",
```

Inside the react client, the graphql endpoint then is pretty simple,
just set to `/graphql`.

## GraphiQL

The Rails app is only an API, it does not handle anything that would
be delivered by some other means. This also means that the GraphiQL
development front end is not available. Instead, I've been using a
stand-alone GraphiQL client, <https://github.com/skevy/graphiql-app>.
