import React from 'react'
import {Redirect} from 'react-router-dom'
import {graphql, gql} from 'react-apollo'

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
      window.sessionStorage.setItem('token', token)
      this.setState({
        loggedIn: true,
      })
    })
  }


  render() {
    if (this.state.loggedIn) return <Redirect to="/"/>
    return (
      <div>
        <form onSubmit={this.handleSubmit}>
          <div>
            <label>
              Email: <input type="email" name="email" value={this.state.email} onChange={this.handleChange}/>
            </label>
          </div>
          <div>
            <label>
              Password:  <input type="text" name="password" value={this.state.password} onChange={this.handleChange}/>
            </label>
          </div>
          <div>
            <input type="submit"/>
          </div>
        </form>
      </div>
    )
  }
}

const LogInWithMutation = graphql(logInMutation)(LogIn)
export default LogInWithMutation
