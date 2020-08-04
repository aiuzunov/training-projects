import React, {useState, useEffect} from 'react';
import './App.css';

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
