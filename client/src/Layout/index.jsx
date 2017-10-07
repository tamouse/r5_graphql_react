import React from 'react'
import styled from 'styled-components'
import NavMenu from './NavMenu'

const Layout = props => {
  return (
    <LayoutWrapper>
      <FullHeight>
        <AppHeader>
          <NavMenu/>
        </AppHeader>
        <AppBody>
          {props.children}
        </AppBody>
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
`

const AppBody = styled.main`
  flex: 7;
  margin: 50px auto;
  width: 70%;
`

