import React from 'react';
import { Navbar, Nav, NavItem } from 'react-bootstrap';
import { IndexLinkContainer, LinkContainer } from 'react-router-bootstrap';

function NavigationBar() {
  return (
    <Navbar collapseOnSelect>
      <Navbar.Header>
        <Navbar.Brand>
          <LinkContainer to='/'><a>iSignature</a></LinkContainer>
        </Navbar.Brand>
      </Navbar.Header>

      <Navbar.Collapse>
        <Nav pullRight>
          <IndexLinkContainer to="/b" activeClassName="active">
            <NavItem>click me</NavItem>
          </IndexLinkContainer>
        </Nav>
      </Navbar.Collapse>
    </Navbar>
  );
}

export default NavigationBar;
