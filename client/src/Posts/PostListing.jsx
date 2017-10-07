import React from 'react'
import PropTypes from 'prop-types'
import {Grid} from 'react-bootstrap'
import PostSummary from "./PostSummary";

const PostListing = props => {
  const {posts, ...rest} = props
  return (
    <Grid fluid={true}>
      {posts.map(post => <PostSummary key={`post-summary-${post.id}`} {...rest} post={post}/>)}
    </Grid>
  )
}

PostListing.propTypes = {
  viewer: PropTypes.object,
  posts: PropTypes.array.isRequired,
}

export default PostListing
