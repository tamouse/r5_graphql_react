import React from 'react';
import { render, shallow } from 'enzyme';
import PostDetail from './PostDetail';

test("It should render the PostDetail Component", () => {

  const actual = render(<PostDetail/>)
  expect(actual).toMatchSnapshot()

})
