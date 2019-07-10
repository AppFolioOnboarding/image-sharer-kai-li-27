import { action, observable } from 'mobx';

export default class FeedbackStore {
  @observable name = '';
  @observable comments = '';
  @observable failed = false;
  @observable submissionMessage = '';

  @action setName(name) {
    this.name = name;
  }

  @action setComments(comments) {
    this.comments = comments;
  }

  @action setFailed(failed) {
    this.failed = failed;
  }

  @action setSubmissionMessage(message) {
    this.submissionMessage = message;
  }
}
