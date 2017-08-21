import React from 'react';
import ReactDOM from 'react-dom';
import registerServiceWorker from './registerServiceWorker';

// assets
import 'bootstrap/dist/css/bootstrap.css';
import 'bootswatch/paper/bootstrap.css';
import 'font-awesome/css/font-awesome.css';

import { Routes } from './config';

ReactDOM.render(<Routes />, document.getElementById('root'));
registerServiceWorker();
