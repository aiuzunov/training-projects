import React, { useEffect } from 'react';
import NavBar from './NavBar';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';

function ProductsPage(){

    return(
        <div>
         
         <NavBar />
  
         <footer> All Rights Reserved </footer>
         
        
        </div>
        
    );
}



export default ProductsPage;