import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { withRouter } from 'react-router-dom';
import NavBar from './NavBar';


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
            <NavBar/>
            <button onClick={history.goBack}>Go back</button>   
         
            <div className="container">
        <div className="left-column">
<img src={product.image} alt=""/>
<img data-image="black" src="" alt=""></img>
<img data-image="blue" src="" alt=""></img>
<img data-image="red" className="active" src="" alt=""></img>
</div>



<div className="right-column">


<div className="product-description">
  <span>Headphones</span>
  <h1>{product.name}</h1>
  <p>{product.description}</p>
</div>


<div className="product-configuration">

  
  <div className="product-color">
    <span>Color</span>

    <div className="color-choose">
      <div>
        <input data-image="red" type="radio" id="red" name="color" value="red" checked></input>
        <label for="red"><span></span></label>
      </div>
      <div>
        <input data-image="blue" type="radio" id="blue" name="color" value="blue"></input>
        <label for="blue"><span></span></label>
      </div>
      <div>
        <input data-image="black" type="radio" id="black" name="color" value="black"></input>
        <label for="black"><span></span></label>
      </div>
      
    </div>
    <div className="product-quantity">
      Qty: <select value={quantity} onChange={(e) => {setQuantity(e.target.value)}}>
                            {[...Array(product.count_in_stock).keys()].map(instock=>
                                <option key={instock+1} value={instock + 1}>{instock+1}</option>  )}
                        </select>
      </div>
  </div>
        
 
    </div>


    <div className="product-price">
     <span>{product.price} лв.</span>
     {product.count_in_stock > 0 && <button onClick={AddToCart}  className="cart-btn">Добави в количката</button>}
    </div>
    </div>
    </div>
    );
           
           
          
           
        </div>
        
    );
}

export default withRouter(ProductDetailsPage);