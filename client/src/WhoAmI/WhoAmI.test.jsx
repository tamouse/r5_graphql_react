import React from 'react'
import {shallow} from 'enzyme'
import WhoAmI from './WhoAmI'

test("Renders the WhoAmI component", ()=>{
  let actual = shallow(<WhoAmI viewer={{name: 'Fred', email: 'fred_murtz@lucy.com'}}/>)
  expect(actual).toMatchSnapshot()
})
