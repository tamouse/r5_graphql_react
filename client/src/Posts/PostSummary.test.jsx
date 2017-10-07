import React from 'react'
import {render} from 'enzyme'
import PostSummary from './PostSummary'

test("Renders PostSummary Component", ()=>{
  const post = {
    id: 1,
    title: "One",
    excerpt: "excerpt one",
    body: "post one body",
    publishedAt: "2017-10-12T12:00:00",
  }

  const actual = render(<PostSummary post={post}/>)
  expect(actual).toMatchSnapshot()
  expect(actual.text()).toMatch(/One/)
  expect(actual.text()).toMatch(/excerpt one/)
})
