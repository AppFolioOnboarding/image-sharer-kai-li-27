/* eslint-env mocha */

import assert from 'assert';
import { shallow } from 'enzyme';
import React from 'react';
import CommentsForm from '../../components/CommentsForm';

describe('<CommentsForm />', () => {
  it('should render correctly', () => {
    const wrapper = shallow(<CommentsForm />);
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
  });
});
