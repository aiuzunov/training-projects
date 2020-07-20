import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { withRouter } from 'react-router-dom';


function ProductDetailsPage({ match , history }) {

    useEffect(() => {
        dispatch(detailsProduct(match.params.id));
        //getProduct();
        console.log(history);
    },[]);
   // const [product,setProduct] = useState({})
   const [quantity,setQuantity] = useState(1);
   const productDetails = useSelector(state => state.productDetails);
   const { product, loading, error} = productDetails;
   const dispatch = useDispatch();

   const AddToCart = () => {
    history.push('/cart/' + match.params.id + '?qty=' + quantity);
  };

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
            <button onClick={history.goBack}>Go back</button>                
            
            <div className="details"> 
                <div className="details-image">
                    <img src={product.image} alt="Product Image"></img>
                </div>
            <div className="details-info">
                <ul>
                    <li>
                        <h4>{product.name}</h4>
                    </li>
                    <li>
                        <b>{product.price} лв.</b>
                    </li>
                    <li>
                        Description:
                        <div>
                            {product.description}
                        </div>
                       
                    </li>
                </ul>    
            </div>
            <div className="details-action"> 
                <ul>
                    <li>
                        Price : {product.price} лв.
                    </li>
                    <li>
                        Status : {product.count_in_stock > 0? "In stock" : "Out of stock"}
                    </li>
                    <li>
                        Qty: <select value={quantity} onChange={(e) => {setQuantity(e.target.value)}}>
                            {[...Array(product.count_in_stock).keys()].map(instock=>
                                <option key={instock+1} value={instock + 1}>{instock+1}</option>  )}
                        </select>
                    </li>
                    <li>
                        {product.count_in_stock > 0 && <button onClick={AddToCart}  className="button">Add to Cart</button>}
                
                    </li>
                </ul>
            
            
            </div>
            </div>
        </div>
    );
}

export default withRouter(ProductDetailsPage);