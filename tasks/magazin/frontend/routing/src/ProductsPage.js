import React, { useEffect, useState } from 'react';
import PListNavBar from './PListNavBar';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listTags } from './actions/tagsActions';
import Axios from 'axios';


function ProductsPage(){
    const [count, setCount] = useState([]);
    useEffect(() => {
        getCount();
      },[]);
    const getCount = async () => {
        try {
          const response = await Axios.get(
           `/orders/count`
         );
         console.log(response.data[0].count)
         setCount(response.data[0].count);
        } catch (err) {
          console.log(err.message);
        }
      };

    return(
        <div>
        <div>
            Брой Поръчки: {count}
        </div>

         <PListNavBar />


        </div>

    );
}



export default ProductsPage;
