import React from 'react';
import { Button, Form, FormGroup, Label, Input, Alert } from 'reactstrap';
import { post } from '../utils/helper';

class CommentsForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      name: '',
      comments: '',
      failed: false,
      submissionMessage: ''
    };
  }

  onNameChange = (e) => {
    this.setState({ name: e.target.value });
  }

  onCommentsChange = (e) => {
    this.setState({ comments: e.target.value });
  }

  submitFeedback = () => {
    const promise = post('/api/feedbacks', {
      name: this.state.name,
      comments: this.state.comments
    });

    return promise
      .then(response => this.setState({ failed: false, submissionMessage: response.message }))
      .catch(error => this.setState({ failed: true, submissionMessage: error.data.message }))
      .then(() => this.setState({ name: '', comments: '' }));
  }

  render() {
    return (
      <Form>
        {this.state.submissionMessage !== '' &&
          <Alert color={this.state.failed ? 'danger' : 'success'}>
            {this.state.submissionMessage}
          </Alert>}
        <FormGroup>
          <Label className="l">Your name:</Label>
          <Input type="text" name="name" value={this.state.name} onChange={this.onNameChange} />
        </FormGroup>
        <FormGroup>
          <Label>Comments:</Label>
          <Input
            type="textarea"
            name="comments"
            value={this.state.comments}
            onChange={this.onCommentsChange}
          />
        </FormGroup>
        <Button color="primary" onClick={this.submitFeedback}>Submit</Button>
      </Form>
    );
  }
}

export default CommentsForm;
