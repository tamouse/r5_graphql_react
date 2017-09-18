import React from 'react'
import {Link} from 'react-router-dom'
import {userLoggedIn} from "../Utils/index";
import styled from 'styled-components'

const StyledLink = styled(Link)`
  color: white;
  padding: 0 20px;
`

const UserMenu = props => {
  if (userLoggedIn()) {
    return (
      <StyledLink to="/logout">Log Out</StyledLink>
    )
  } else {
    return (
      <div>
        <StyledLink to="/login">Log In</StyledLink>
        <StyledLink to="/signup">Sign Up</StyledLink>
      </div>
    )
  }
}

export default UserMenu
