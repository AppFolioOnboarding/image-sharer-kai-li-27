import React from 'react';
import { Container } from 'reactstrap';
import Header from './Header';
import Footer from './Footer';
import CommentsForm from './CommentsForm';
import FeedbackStore from '../stores/feedbackStore';

export default function App() {
  const feedbackStore = new FeedbackStore();
  return (
    <Container >
      <Header title="Tell us what you think" />
      <CommentsForm feedbackStore={feedbackStore} />
      <Footer />
    </Container>
  );
}

/* TODO: Add Prop Types check*/
