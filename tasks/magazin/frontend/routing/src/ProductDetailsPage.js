import React from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';


function ProductDetailsPage({ match }){
    useEffect(() => {
        dispatch(detailsProduct());
        //getProduct();
        console.log(match);
    },[]);
   // const [product,setProduct] = useState({})
   const productDetails = useSelector(state => state.productDetails);
   const { product, loading, error} = productDetails;
   const dispatch = useDispatch();
   /* const getProduct = async () => {
        try {
            const response = await fetch(`http://localhost:5000/product/${match.params.id}`)
            const product = await response.json();
            setProduct(product);
            console.log(product);
        } catch (err) {
          console.log(err.message);
        }
      }
*/
    return(
        loading ? <div>Loading...</div> : error ? <div>Error</div> : 
        <div>
            <h1>{product.name}</h1>
            <h1>{product.price}</h1>
            <h1>{product.description}</h1>
        </div>
    );
}

export default ProductDetailsPage;