import React from 'react'
import {ApolloClient} from 'apollo-client'
import {createHttpLink} from 'apollo-link-http'
import {ApolloLink} from 'apollo-link'
import {InMemoryCache} from 'apollo-cache-inmemory'
import {ApolloProvider} from 'react-apollo'

import {BrowserRouter, Route} from 'react-router-dom'
import WhoAmI from './WhoAmI/index'
import Layout from "./Layout/index"
import LogIn from './Authentication/LogIn'
import SignUp from './Authentication/SignUp'
import LogOut from "./Authentication/LogOut"
import PostsIndex from "./Posts"

const httpLink = createHttpLink({
  uri: '/graphql',
  opts: {
    credentials: 'same-origin'
  }
})

const middlewareLink = new ApolloLink((operation, forward) => {
  // get the authentication token from session storage if it exists
  const token = sessionStorage.getItem('token');

  operation.setContext({
    headers: {
      authorization: token ? `Bearer ${token}` : null
    }
  })

  return (forward(operation))
})

const link = middlewareLink.concat(httpLink)

const client = new ApolloClient({
  link,
  cache: new InMemoryCache()
})

class App extends React.Component {
  render() {
    return (
      <ApolloProvider client={client}>
        <BrowserRouter>
          <Layout>
            <Route exact path="/" component={WhoAmI}/>
            <Route exact path="/login" component={LogIn}/>
            <Route exact path="/signup" component={SignUp}/>
            <Route exact path="/logout" component={LogOut}/>
            <Route exact path="/posts" component={PostsIndex}/>
          </Layout>
        </BrowserRouter>
      </ApolloProvider>
    );
  }
}

export default App;
