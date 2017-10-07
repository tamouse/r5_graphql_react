import React from 'react';
import { render, shallow } from 'enzyme';
import NewPost from './NewPost';

test("It should render the NewPost Component", () => {

  const actual = render(<NewPost/>)
  expect(actual).toMatchSnapshot()

})
