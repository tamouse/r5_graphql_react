import React from 'react'
import PropTypes from 'prop-types'
import {
  Col,
  Row,
  Grid,
  Panel,
  ListGroup,
  ListGroupItem
} from 'react-bootstrap'

const WhoAmi = props => {
  const {viewer: {self: viewer}} = props
  return(
    <Grid fluid={true}>
      <Row>
        <Col sm={12}>
          <Panel header={'Who am I?'}>
            <ListGroup>
              <ListGroupItem>Name: {viewer.name}</ListGroupItem>
              <ListGroupItem>Email: {viewer.email}</ListGroupItem>
            </ListGroup>
          </Panel>
        </Col>
      </Row>

    </Grid>
  )
}

WhoAmi.propTypes = {
  viewer: PropTypes.object.isRequired,
}

export default WhoAmi
