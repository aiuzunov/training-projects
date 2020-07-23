import React, { useEffect } from 'react';
import PListNavBar from './PListNavBar';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listTags } from './actions/tagsActions';

function ProductsPage(){
    

    return(
        <div>
         
         <PListNavBar />
         
        
        </div>
        
    );
}



export default ProductsPage;