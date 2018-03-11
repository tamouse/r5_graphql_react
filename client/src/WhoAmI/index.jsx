import React from 'react'
import {graphql} from 'react-apollo'
import gql from 'graphql-tag'
import './index.css'
import WhoAmI from './WhoAmI'

const WhoAmIQuery = gql`query WhoAmi {viewer {self {name email}}}`

export const WhoAmIContainer = props => {
  const {data} = props
  const {loading, error, viewer} = data

  if (loading) return <p>Loading...</p>

  if (error) return (
    <React.Fragment>
      <h2>ERROR!!</h2>
      <p>Error returned from query</p>
      <p>{JSON.stringify(error)}</p>
    </React.Fragment>
  )

  if (viewer === null) return (
    <React.Fragment>
      <h2>ERROR!!</h2>
      <p>No viewer returned, how is this possible?</p>
      <p>{JSON.stringify(viewer)}</p>
    </React.Fragment>
  )

  return (<WhoAmI viewer={viewer}/>)
}

export default graphql(WhoAmIQuery)(WhoAmIContainer)
