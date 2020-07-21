import React from 'react';
import './App.css';
import ProductsPage from './ProductsPage';
import {BrowserRouter as Router,Switch, Route} from 'react-router-dom';
import ProductDetailsPage from './ProductDetailsPage';
import Cart from './Cart';
import SignInScreen from './SignInScreen';
import SignUpScreen from './SignUpScreen';
import CRUDProducts from './CRUDProducts';

function App() {

  return (
    <Router>
      <Switch>

  
      <Route path="/" exact>
        <ProductsPage/>
      </Route>
      <Route path="/product/:id" component={ProductDetailsPage}/>
      <Route path="/cart/:id?" component={Cart} />
      <Route path="/signin" component={SignInScreen}/>
      <Route path="/signup" component={SignUpScreen}/>
      <Route path="/manageproducts" component={CRUDProducts}/>
    </Switch>
    </Router>
  );
}



export default App;
