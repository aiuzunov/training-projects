import React, { useEffect, useState } from 'react';
import PListNavBar from './PListNavBar';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listTags } from './actions/tagsActions';
import Axios from 'axios';


function ProductsPage(props){
    useEffect(() => {
      },[]);


    return(
        <div>


         {props.isDisconnected ? <div></div> : <PListNavBar /> }


        </div>

    );
}



export default ProductsPage;
