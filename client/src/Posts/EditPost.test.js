import React from 'react';
import { render, shallow } from 'enzyme';
import EditPost from './EditPost';

test("It should render the EditPost Component", () => {

  const actual = render(<EditPost/>)
  expect(actual).toMatchSnapshot()

})
