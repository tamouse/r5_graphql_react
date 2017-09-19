import React from 'react'
// import PropTypes from 'prop-types'
import styled from 'styled-components'
import {graphql, gql} from 'react-apollo'
import PostSummary from './PostSummary'

const listPosts = gql`query Posts{viewer {public_posts {id title excerpt publishedAt}}}`

const PostsIndex = props => {
  const { data: { loading, error, viewer}, ...rest } = props

  if (loading) return <Loading>Loading...</Loading>
  if (error) return (
    <Error>
      <h3>Error:</h3>
      <p>{error}</p>
    </Error>
  )

  const {public_posts} = viewer

  if (!public_posts) return (
    <PostsListing {...rest}>No posts</PostsListing>
  )

  return (
    <PostsListing>
      <h1>Posts</h1>
      {public_posts.map((post, idx) => {
        return <PostSummary post={post} key={idx} />
      })}
    </PostsListing>
  )
}

const PostsIndexWithData = graphql(listPosts)(PostsIndex)

PostsIndexWithData.propTypes = {}
PostsIndexWithData.defaultProps = {}

export default PostsIndexWithData

const Loading = styled.div`
  font-size: 2em;
  color: RebeccaPurple;
  background-color: PapayaWhip;
  margin: 10px;
  padding: 10px;
`

const Error = styled.div`
  backgound-color: rgb(245, 147, 156, 0.7);
  color: red;
  border: 1 solid red;
  margin: 10px;
  padding: 10px;
`

const PostsListing = styled.div`
  backgound-color: rgb(252, 243, 207, 0.7);
  color: black;
  border: 1 solid black;
  margin: 10px;
  padding: 10px;  
`
