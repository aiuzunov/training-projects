import React, {useState, useEffect} from 'react';
import './App.css';
import {Link, NavLink} from 'react-router-dom';

function Shop() {

    useEffect(() => {
        fetchItems();
    },[]);

    const [items, setItems] = useState([]);

    const fetchItems = async () =>  {
        const data = await fetch('https://fortnite-api.com/v2/shop/br');
        const items = await data.json();
        console.log(items.data.daily.entries);
        setItems(items.data.daily.entries);
    }

  return (
    <div>
     {items.map(item => (
         <h1 key={item.offerId}><Link to={`/shop/${item.offerId}`}>{item.items[0].name}</Link></h1>
     ))}
    </div>
  );
}

export default Shop;
