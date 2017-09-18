import React from 'react'
import {Redirect} from 'react-router-dom'

const LogOut = props => {
  window.sessionStorage.removeItem('token')

  return <Redirect to="/"/>
}

export default LogOut
