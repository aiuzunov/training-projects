import React from 'react';
import './App.css';
import NavBar from './NavBar';
import ProductsPage from './ProductsPage';
import {BrowserRouter as Router,Switch, Route} from 'react-router-dom';
import ProductDetailsPage from './ProductDetailsPage';

function App() {
  return (
    <Router>
      <Route path="/" exact>
        <ProductsPage/>
      </Route>
      <Route path="/product123">
        <ProductDetailsPage/>
      </Route>
    <div className="App">
    </div>
    </Router>
  );
}



export default App;
