import React from 'react'
import {shallow} from 'enzyme'
import NavMenu from './NavMenu'


test("Renders the NavMenu", () => {
  let actual = shallow(<NavMenu/>)
  expect(actual).toMatchSnapshot()
})

