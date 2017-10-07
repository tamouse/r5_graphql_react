import React from 'react'
import {shallow} from 'enzyme'
import Layout from './index'

test("Renders Layout without blowing up", () => {
  let actual = shallow(<Layout/>)
  expect(actual).toMatchSnapshot()
})
