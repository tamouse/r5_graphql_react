import React from 'react'
import PropTypes from 'prop-types'
import {Grid, Form, Button} from 'react-bootstrap'
import FieldGroup from '../Utils/FieldGroup'

const LogInForm = ({handleChange, handleSubmit, ...props}) => {
  return (
    <Grid fluid={true}>
      <Form onSubmit={handleSubmit}>
        <FieldGroup {...props} id={'login-field-email'} name={'email'} label={'Email'} type={'email'} onChange={handleChange}/>
        <FieldGroup {...props} id={'login-field-password'} name={'password'} label={'Password'} onChange={handleChange}/>
        <Button type={'submit'}>Log In</Button>
      </Form>
    </Grid>
  )
}

LogInForm.propTypes = {
  handleChange: PropTypes.func.isRequired,
  handleSubmit: PropTypes.func.isRequired,
}
LogInForm.defaultProps = {}

export default LogInForm
