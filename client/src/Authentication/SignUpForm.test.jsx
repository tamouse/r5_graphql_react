import React from 'react';
import {render} from 'enzyme';
import SignUpForm from './SignUpForm';
const noOp = () => {}
test("It should render the SignUpForm Component", () => {

  const actual = render(<SignUpForm handleChange={noOp} handleSubmit={noOp}/>)
  expect(actual).toMatchSnapshot()

})
