import React from 'react'
import {graphql} from 'react-apollo'
import gql from 'graphql-tag'
import './index.css'
import WhoAmI from './WhoAmI'

const WhoAmIQuery = gql`query WhoAmi {viewer {name email}}`

export const WhoAmIContainer = props => {
  const {data} = props
  const {loading, error, viewer} = data

  if (loading) return <p>Loading...</p>

  if (error) return <p>{error.message}</p>

  if (viewer === null) return <p>No viewer returned (which is weird)</p>

  return (<WhoAmI viewer={viewer}/>)
}

export default graphql(WhoAmIQuery)(WhoAmIContainer)
