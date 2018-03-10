import React from 'react'
import {Redirect} from 'react-router-dom'
import {graphql} from 'react-apollo'
import gql from 'graphql-tag'
import LogInForm from './LogInForm'

const logInMutation = gql`
mutation LogInUser($credentials: AuthProviderCredentials) {
  loginUser(credentials: $credentials)
  {token user {name email}}
}`

class LogIn extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      email: '',
      password: '',
      mutate: props.mutate,
      loggedIn: false,
    }

    this.handleChange = this.handleChange.bind(this)
    this.handleSubmit = this.handleSubmit.bind(this)
  }

  handleChange(e) {
    const target = e.target
    const value = target.type === 'checkbox' ? target.checked : target.value
    const name = target.name

    this.setState({
      [name]: value
    })
  }


  handleSubmit(e) {
    e.preventDefault()

    const credentials = {
      email: this.state.email,
      password: this.state.password,
    }

    this.state.mutate({
      variables: {
        credentials,
      },
    }).then(response => {
      let token = response.data.loginUser.token
      global.sessionStorage.setItem('token', token)
      this.setState({
        loggedIn: true,
      })
    })
  }


  render() {
    if (this.state.loggedIn) return <Redirect to="/"/>
    return (<LogInForm handleChange={this.handleChange} handleSubmit={this.handleSubmit}/>)
  }
}

const LogInWithMutation = graphql(logInMutation)(LogIn)
export default LogInWithMutation
