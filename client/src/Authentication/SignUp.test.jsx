import React from 'react'
import {shallow} from 'enzyme'
import SignUp from './SignUp'

test("Renders the SignUp component", ()=>{
  let actual = shallow(<SignUp/>)
  expect(actual).toMatchSnapshot()
})

