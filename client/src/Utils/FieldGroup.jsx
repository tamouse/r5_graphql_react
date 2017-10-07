import React from 'react'
import PropTypes from 'prop-types'
import {FormGroup, ControlLabel, FormControl, HelpBlock} from 'react-bootstrap'

const FieldGroup = ({id, name, label, help, ...props}) => {
  return(
    <FormGroup controlId={id}>
      <ControlLabel>{label}</ControlLabel>
      <FormControl {...props} name={name}/>
      {help && <HelpBlock>{help}</HelpBlock>}
    </FormGroup>
  )
}
FieldGroup.propTypes = {
  id: PropTypes.string.isRequired,
  name: PropTypes.string.isRequired,
  label: PropTypes.string.isRequired,
  help: PropTypes.string,
}
export default FieldGroup
