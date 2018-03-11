import React from 'react'
import {
  Nav,
  Navbar,
  NavbarBrand,
  NavItem,
} from 'react-bootstrap'
import {LinkContainer} from 'react-router-bootstrap'
import {Link} from 'react-router-dom'
import {isUserLoggedIn} from '../Utils';

const NavMenu = props => {
  const userMenu = () => {
    if (isUserLoggedIn()) {
      return (<LinkContainer to={'/logout'}><NavItem>Log Out</NavItem></LinkContainer>)
    } else {
      return (
        <React.Fragment>
          <LinkContainer key={1} to={'/login'}><NavItem>Log In</NavItem></LinkContainer>
          <LinkContainer key={2} to={'/signup'}><NavItem>Sign Up</NavItem></LinkContainer>
        </React.Fragment>
      )
    }
  }
  return (
    <Navbar collapseOnSelect>
      <Navbar.Header>
        <NavbarBrand>
          <Link to={'/'}>R5+GraphQL+React</Link>
        </NavbarBrand>
      </Navbar.Header>
      <Nav>
        <LinkContainer to={'/posts'}>
          <NavItem>Posts</NavItem>
        </LinkContainer>
      </Nav>
      <Nav pullRight>
        {userMenu()}
      </Nav>
    </Navbar>
  )
}

export default NavMenu

