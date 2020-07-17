import React from 'react';
import './App.css';
import NavBar from './NavBar';
import ProductsPage from './ProductsPage';
import {BrowserRouter as Router,Switch, Route} from 'react-router-dom';
import ProductDetailsPage from './ProductDetailsPage';
import Cart from './Cart';

function App() {
  return (
    <Router>
      <Switch>

  
      <Route path="/" exact>
        <ProductsPage/>
      </Route>
      <Route path="/product/:id" component={ProductDetailsPage}/>
      <Route path="/cart/:id?" component={Cart} />
    </Switch>
    </Router>
  );
}



export default App;
