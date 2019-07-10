import React from 'react';
import { Button, Form, FormGroup, Label, Input, Alert } from 'reactstrap';
import { observer } from 'mobx-react';
import { post } from '../utils/helper';

@observer
class CommentsForm extends React.Component {
  constructor(props) {
    super(props);
    this.feedbackStore = this.props.feedbackStore;
  }

  onNameChange = (e) => {
    this.feedbackStore.setName(e.target.value);
  }

  onCommentsChange = (e) => {
    this.feedbackStore.setComments(e.target.value);
  }

  submitFeedback = () => {
    const promise = post('/api/feedbacks', {
      name: this.feedbackStore.name,
      comments: this.feedbackStore.comments
    });

    return promise
      .then((response) => {
        this.feedbackStore.setFailed(false);
        this.feedbackStore.setSubmissionMessage(response.message);
      })
      .catch((error) => {
        this.feedbackStore.setFailed(true);
        this.feedbackStore.setSubmissionMessage(error.data.message);
      })
      .then(() => {
        this.feedbackStore.setName('');
        this.feedbackStore.setComments('');
      });
  }

  render() {
    return (
      <Form>
        {this.feedbackStore.submissionMessage !== '' &&
          <Alert color={this.feedbackStore.failed ? 'danger' : 'success'}>
            {this.feedbackStore.submissionMessage}
          </Alert>}
        <FormGroup>
          <Label className="l">Your name:</Label>
          <Input type="text" name="name" value={this.feedbackStore.name} onChange={this.onNameChange} />
        </FormGroup>
        <FormGroup>
          <Label>Comments:</Label>
          <Input
            type="textarea"
            name="comments"
            value={this.feedbackStore.comments}
            onChange={this.onCommentsChange}
          />
        </FormGroup>
        <Button color="primary" onClick={this.submitFeedback}>Submit</Button>
      </Form>
    );
  }
}

export default CommentsForm;
