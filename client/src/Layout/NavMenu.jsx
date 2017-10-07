import React from 'react'
import {
  Nav,
  Navbar,
  NavbarBrand,
  NavItem,
} from 'react-bootstrap'
import {LinkContainer} from 'react-router-bootstrap'
import {Link} from 'react-router-dom'
import {userLoggedIn} from '../Utils';


const NavMenu = props => {
  const userMenu = () => {
    if (userLoggedIn()) {
      return (<LinkContainer to={'/logout'}><NavItem>Log Out</NavItem></LinkContainer>)
    } else {
      return (
        [
          <LinkContainer key={1} to={'/login'}><NavItem>Log In</NavItem></LinkContainer>,
          <LinkContainer key={2} to={'/signup'}><NavItem>Sign Up</NavItem></LinkContainer>
        ]
      )
    }
  }


  return (
    <Navbar collapseOnSelect>
      <Navbar.Header>
        <NavbarBrand>
          <Link to={'/'}>R5+GraphQL+React</Link>
        </NavbarBrand>
        <Navbar.Toggle/>
      </Navbar.Header>
      <Navbar.Collapse>
        <Nav>
          <LinkContainer to={'/posts'}>
            <NavItem>Posts</NavItem>
          </LinkContainer>
        </Nav>
        <Nav pullRight>
          {userMenu()}
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  )
}

export default NavMenu

