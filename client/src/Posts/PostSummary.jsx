import React from 'react'
import PropTypes from 'prop-types'
import styled from 'styled-components'
import moment from 'moment'

const PostSummary = props => {
  const {post} = props
  return (<PostSummaryWrapper>
    <PostSummaryTitle>{post.title}</PostSummaryTitle>
    <PostSummaryPublished>{moment(post.publishedAt).format("Do MMMM YYYY")}</PostSummaryPublished>
    <PostSummaryExcerpt>{post.excerpt}</PostSummaryExcerpt>
  </PostSummaryWrapper>)
}

PostSummary.propTypes = {
  post: PropTypes.object.isRequired,
}

export default PostSummary

const PostSummaryWrapper = styled.article``

const PostSummaryTitle = styled.h2``

const PostSummaryPublished = styled.p`
  font-size: 0.8em;
  color: #aaa;
`

const PostSummaryExcerpt = styled.p`
  font-style: italic;
`
