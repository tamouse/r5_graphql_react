import React from 'react';
import {shallow} from 'enzyme';
import PostListing from './PostListing';

test("It should render the PostListing Component", () => {
  const posts = [
    {id: 1, title: 'one', body: 'post one'},
    {id: 2, title: 'two', body: 'post two'}
  ]
  const actual = shallow(<PostListing posts={posts}/>)
  expect(actual).toMatchSnapshot()
})
