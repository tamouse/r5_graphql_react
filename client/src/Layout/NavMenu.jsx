import React from 'react'
import styled from 'styled-components'
import { Link } from 'react-router-dom'


const links = [
  {to: "/", text: "Home"},
  {to: "/posts", text: "Posts"},
]

const NavMenu = props => {

  return (
    <NavDiv>
      {links.map((link, idx) => {
        return <StyledLink key={`link-${idx}`} to={link.to}>{link.text}</StyledLink>
      })}
    </NavDiv>
  )
}

export default NavMenu

const NavDiv = styled.nav`
  padding: 10px;
`

const StyledLink = styled(Link)`
  padding: 5px;
  color: white;
`
