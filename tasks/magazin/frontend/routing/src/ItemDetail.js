import React, {useState, useEffect} from 'react';
import './App.css';
import {Link, NavLink} from 'react-router-dom';

function ItemDetail() {

    useEffect(() => {
        fetchItem();
    },[]);

    const [item, setItem] = useState({});

    const fetchItem = async () =>  {
       
    }

  return (
    <div>
     <h1>Item</h1>
    </div>
  );
}

export default ItemDetail;
