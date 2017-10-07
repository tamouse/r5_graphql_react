import React from 'react'
import {shallow} from 'enzyme'
import LogOut from './LogOut'

test("Renders the Login component", ()=>{
  let actual = shallow(<LogOut/>)
  expect(actual).toMatchSnapshot()
})

