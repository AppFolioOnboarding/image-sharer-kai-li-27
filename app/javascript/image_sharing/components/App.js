import React from 'react';
import { Container } from 'reactstrap';
import Header from './Header';
import Footer from './Footer';
import CommentsForm from './CommentsForm';

export default function App() {
  return (
    <Container >
      <Header title="Tell us what you think" />
      <CommentsForm />
      <Footer />
    </Container>
  );
}

/* TODO: Add Prop Types check*/
