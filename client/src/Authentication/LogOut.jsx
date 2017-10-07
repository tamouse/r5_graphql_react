import React from 'react'
import {Redirect} from 'react-router-dom'

const LogOut = props => {
  global.sessionStorage.removeItem('token')

  return <Redirect to="/"/>
}

export default LogOut
