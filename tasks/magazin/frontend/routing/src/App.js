import React from 'react';
import './App.css';
import ProductsPage from './ProductsPage';
import {BrowserRouter as Router,Switch, Route} from 'react-router-dom';
import ProductDetailsPage from './ProductDetailsPage';
import Cart from './Cart';
import SignInScreen from './SignInScreen';
import SignUpScreen from './SignUpScreen';
import BackOffice from './BackOffice';
import SignInEmployees from './signInEmployees';
import PrivateRoute from './PrivateRoute';
import UserProfile from './userProfile';
import EmpSignUpScreen from './EmpSignUpScreen';
import ProfileOrderList from './ProfileOrderList';
import OrderDetailsPage from './orderDetailsPage';
import BackOfficeStats from './BackOfficeStats';

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
      <Route path="/signinemp" component={SignInEmployees}/>
      <Route path="/profile" component={UserProfile}/>
      <Route path="/empsign" component={EmpSignUpScreen}/>
      <Route path="/orders" component={ProfileOrderList}/>
      <Route path="/order/:id" component={OrderDetailsPage}/>
      <Route path="/backoffice/stats" component={BackOfficeStats}/>

      <PrivateRoute path='/backoffice' component={BackOffice} />



    </Switch>
    </Router>
  );
}



export default App;
