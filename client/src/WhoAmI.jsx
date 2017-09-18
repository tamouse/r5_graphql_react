import React from 'react'
import {graphql, gql} from 'react-apollo'
import './WhoAmI.css'

const WhoAmIQuery = gql`query WhoAmi {viewer {name email}}`

const WhoAmI = props => {
  const {data} = props
  const {loading, error, viewer} = data

  if (loading) return <p>Loading...</p>

  if (error) return <p>{error.message}</p>

  if (viewer === null) return <p>No viewer returned (which is weird)</p>

  return (
    <div className="WhoAmI">
      <h2>Who Am I?</h2>
      <ul className="WhoAmI__List">
        <li><strong>Name:</strong> {viewer.name}</li>
        <li><strong>Email:</strong> {viewer.email}</li>
      </ul>

    </div>
  )
}


const WhoAmIWithData = graphql(WhoAmIQuery)(WhoAmI)

export default WhoAmIWithData
