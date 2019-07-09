/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import sinon from 'sinon';
import * as api from '../../utils/helper';
import CommentsForm from '../../components/CommentsForm';

describe('<CommentsForm />', () => {
  let wrapper;
  beforeEach(() => {
    wrapper = shallow(<CommentsForm />);
  });

  afterEach(() => {
    sinon.restore();
  });

  it('should render correctly', () => {
    const groups = wrapper.find('FormGroup');

    assert.strictEqual(groups.length, 2);

    assert.strictEqual(groups.at(0).find('Input').length, 1);
    assert.strictEqual(groups.at(0).find('Input').prop('type'), 'text');
    assert.strictEqual(groups.at(0).find('Label').length, 1);
    assert.strictEqual(groups.at(0).find('Label').children().text(), 'Your name:');

    assert.strictEqual(groups.at(1).find('Input').length, 1);
    assert.strictEqual(groups.at(1).find('Input').prop('type'), 'textarea');
    assert.strictEqual(groups.at(1).find('Label').length, 1);
    assert.strictEqual(groups.at(1).find('Label').children().text(), 'Comments:');

    assert.strictEqual(wrapper.find('Button').length, 1);
    assert.strictEqual(wrapper.find('Button').children().text(), 'Submit');

    assert.strictEqual(wrapper.find('Alert').length, 0);

    assert.deepStrictEqual(wrapper.instance().state, {
      name: '',
      comments: '',
      failed: false,
      submissionMessage: ''
    });
  });

  it('should show error when submission fails', () => {
    sinon.stub(api, 'post').rejects({ data: { message: 'failed' } });

    return wrapper.instance().submitFeedback().then(() => {
      const alert = wrapper.find('Alert');

      assert.strictEqual(alert.length, 1);
      assert.strictEqual(alert.props().children, 'failed');
      assert.strictEqual(alert.props().color, 'danger');
    });
  });

  it('should show succeeded when submission succeeded', () => {
    sinon.stub(api, 'post').resolves({ message: 'succeeded' });

    return wrapper.instance().submitFeedback().then(() => {
      const alert = wrapper.find('Alert');

      assert.strictEqual(alert.length, 1);
      assert.strictEqual(alert.props().children, 'succeeded');
      assert.strictEqual(alert.props().color, 'success');
    });
  });
});
