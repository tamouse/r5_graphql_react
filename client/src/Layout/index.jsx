import React from 'react'
import styled from 'styled-components'
import UserMenu from "../UserMenu/index"
import NavMenu from './NavMenu'


const Layout = props => {
  return (
    <LayoutWrapper>
      <FullHeight>
        <AppHeader>
          <Title>Welcome to Rails5 + GraphQL + Apollo + React Demo</Title>
          <UserMenu/>
          <NavMenu/>
        </AppHeader>
        <AppBody>
          {props.children}
        </AppBody>
        <AppFooter>
          <GitHubLink>
            <Anchor href="https://github.com/tamouse/r5_graphql_react">Github Repo</Anchor>
          </GitHubLink>
        </AppFooter>
      </FullHeight>
    </LayoutWrapper>
  )
}

export default Layout

const LayoutWrapper = styled.div`
  height: 100%;
`

const FullHeight = styled.div`
  min-height: 100%;
  display: flex;
  flex-direction: column;
`

const AppHeader = styled.header`
  flex: 1;
  height: 120px;
  background-color: black;
  color: white;
  text-align: center;
  margin: 0;
`

const AppBody = styled.main`
  flex: 7;
  margin: 50px auto;
  width: 70%;
`

const AppFooter = styled.footer`
  flex: 1;
  height: 50px;
  background-color: black;
  color: white;
  text-align: center;
  margin: 0;
  padding: 10px;
`

const Title = styled.h2``

const GitHubLink = styled.h3``

const Anchor = styled.a`
  color: white;
  text-decoration: none;
`
