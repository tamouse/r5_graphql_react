import React from 'react'
import {Grid, Form, Button} from 'react-bootstrap'
import PropTypes from 'prop-types'
// import styled from 'styled-components'
import FieldGroup from '../Utils/FieldGroup'

const SignUpForm = ({handleSubmit, handleChange, ...props}) => {
  return (
    <Grid fluid={true}>
      <Form onSubmit={handleSubmit}>
        <FieldGroup {...props} id={'signup-field-name'} name={'name'} label={'Name'} placeholder={'Enter your name'} type={'text'} onChange={handleChange}/>
        <FieldGroup {...props} id={'signup-field-email'} name={'email'} label={'Email'} placeholder={'Enter your email'} type={'email'} onChange={handleChange}/>
        <FieldGroup {...props} id={'signup-field-password'} name={'password'} label={'Password'} type={'text'} onChange={handleChange}/>
        <Button type={'submit'}>Create User</Button>
      </Form>
    </Grid>

  )
}

SignUpForm.propTypes = {
  handleSubmit: PropTypes.func.isRequired,
  handleChange: PropTypes.func.isRequired,
}
SignUpForm.defaultProps = {}

export default SignUpForm
