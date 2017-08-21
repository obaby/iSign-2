import React from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch,
} from 'react-router-dom';

// Components
import { A, B } from '../components/temp';
import { NavigationBar } from '../components/NavigationBar';
import { NotFound } from '../components/Errors';

function Routes() {
  const supportsHistory = 'pushState' in window.history;

  return (
    <Router forceRefresh={!supportsHistory}>
      <div>
        <NavigationBar />

        <div className="container">
          <Switch>
            {/* Root route */}
            <Route exact path="/" component={A} />

            {/* Students */}
            <Route exact path="/b" component={B} />

            {/* 404 Not Found */}
            <Route component={NotFound} />
          </Switch>
        </div>
      </div>
    </Router>
  );
}

export default Routes;
