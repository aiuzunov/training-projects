import React, { useEffect, useState } from 'react';
import PListNavBar from './PListNavBar';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listTags } from './actions/tagsActions';

function ProductsPage(){
    const [count, setCount] = useState([]);
    useEffect(() => {
        getCount();
      },[]); 
    const getCount = async () => {
        try {
            const response = await fetch(
              `/api/orders/count`
            );
            const count = await response.json();
            console.log(count);
            setCount(count);
        } catch (err) {
          console.log(err.message);
        }
      };

    return(
        <div>
        <div>
            Брой Поръчки: {count.count}
        </div>
         
         <PListNavBar />
         
        
        </div>
        
    );
}



export default ProductsPage;