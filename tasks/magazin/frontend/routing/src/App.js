import React from 'react';
import './App.css';
import NavBar from './NavBar';
import ProductsPage from './ProductsPage';
import {BrowserRouter as Router,Switch, Route} from 'react-router-dom';
import ProductDetailsPage from './ProductDetailsPage';

function App() {
  return (
    <Router>
      <Switch>

  
      <Route path="/" exact>
        <ProductsPage/>
      </Route>
      <Route path="/product/:id" component={ProductDetailsPage}/>
    <div className="App">
    </div>
    </Switch>
    </Router>
  );
}



export default App;
