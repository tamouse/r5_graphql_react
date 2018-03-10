import React from 'react'
import {Redirect} from 'react-router-dom'
import {graphql} from 'react-apollo'
import gql from 'graphql-tag'
import SignUpForm from './SignUpForm'

const signUpMutation = gql`
  mutation SignUpUser($credentials: AuthProviderCredentials) {
    createUser(credentials: $credentials)
    {token user {name email}}
  }`


class SignUp extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      name: '',
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
    let updates = {
      [name]: value,
    }

    this.setState(updates)
  }


  handleSubmit(e) {
    e.preventDefault()
    const credentials = {
      name: this.state.name,
      email: this.state.email,
      password: this.state.password,
    }
    this.state.mutate({
      variables: {
        credentials
      },
    }).then(response => {
      let token = response.data.createUser.token
      global.sessionStorage.setItem('token', token)
      this.setState({
        loggedIn: true,
      })
    })
  }

  render() {
    if (this.state.loggedIn) return <Redirect to="/"/>
    return (<SignUpForm handleSubmit={this.handleSubmit} handleChange={this.handleChange}/>)
  }
}

const SignUpWithMutation = graphql(signUpMutation)(SignUp)
export default SignUpWithMutation
