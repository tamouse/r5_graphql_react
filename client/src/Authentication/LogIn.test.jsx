import React from 'react'
import {shallow} from 'enzyme'
import LogIn from './LogIn'

test("Renders the Login component", ()=>{
  let actual = shallow(<LogIn/>)
  expect(actual).toMatchSnapshot()
})

