import React from 'react';
import { render, shallow } from 'enzyme';
import LogInForm from './LogInForm';
const noOp = ()=>{}

test("It should render the LogInForm Component", () => {

  const actual = render(<LogInForm handleChange={noOp} handleSubmit={noOp}/>)
  expect(actual).toMatchSnapshot()

})
