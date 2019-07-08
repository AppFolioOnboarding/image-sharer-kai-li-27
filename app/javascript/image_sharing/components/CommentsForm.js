import React from 'react';
import { Button, Form, FormGroup, Label, Input } from 'reactstrap';

class CommentsForm extends React.Component {
  render() {
    return (
      <Form>
        <FormGroup>
          <Label className="l">Your name:</Label>
          <Input type="text" name="name" />
        </FormGroup>
        <FormGroup>
          <Label>Comments:</Label>
          <Input type="textarea" name="comments" />
        </FormGroup>
        <Button color="primary">Submit</Button>
      </Form>
    );
  }
}

export default CommentsForm;
