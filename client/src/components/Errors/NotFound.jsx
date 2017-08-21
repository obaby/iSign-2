import React from 'react';
import styles from './styles';

function NotFound() {
  return (
    <div className="404-wrapper">
      <h1 style={styles.header}>Oops!</h1>
      <p style={styles.content}>We can't seems to find the page you are looking for.</p>
    </div>
  );
}

export default NotFound;
