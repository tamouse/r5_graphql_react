import React from 'react';

import {storiesOf} from '@storybook/react';
import {action} from '@storybook/addon-actions';
import {linkTo} from '@storybook/addon-links';

import {Button, Welcome} from '@storybook/react/demo';
import WhoAmi from '../WhoAmI/WhoAmI'

storiesOf('Welcome', module).add('to Storybook', () => <Welcome showApp={linkTo('Button')}/>);

storiesOf('Button', module)
    .add('with text', () => <Button onClick={action('clicked')}>Hello Button</Button>)
    .add('with some emoji', () => <Button onClick={action('clicked')}>😀 😎 👍 💯</Button>);

storiesOf('WhoAmI', module)
    .add('with anon viewer', () => <WhoAmi viewer={ {name: null, email: null} }/> )
    .add('with real viewer', () => <WhoAmi viewer={ {name: "Michael Jackson", email: "jacko@dead.com"} }/>)
