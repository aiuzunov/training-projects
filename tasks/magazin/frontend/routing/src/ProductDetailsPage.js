import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { withRouter } from 'react-router-dom';
import NavBar from './NavBar';
import { listTags } from './actions/tagsActions';
import { Select, Button, CircularProgress } from '@material-ui/core';
import AddBoxIcon from '@material-ui/icons/AddBox';
import ArrowBackIcon from '@material-ui/icons/ArrowBack';




function ProductDetailsPage({ match , history }) {

    useEffect(() => {
        dispatch(detailsProduct(match.params.id));
        dispatch(listTags(match.params.id));
    },[]);
   // const [product,setProduct] = useState({})
   const [quantity,setQuantity] = useState(1);
   const productDetails = useSelector(state => state.productDetails);
   const { product, loading, error} = productDetails;
   const tagsList = useSelector(state => state.tagsList);
   const { tags , loading: loadingTags, error: tagsError } = tagsList;
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
       

        loading ? <div> <CircularProgress color="secondary" /></div> : error ? <div>Error</div> : 
        <div >
            <NavBar/>
           
           <Button
        
        onClick={history.goBack}
        variant="contained"
        color="secondary"
        className="backButton"
        startIcon={<ArrowBackIcon />}
      >
        Назад
      </Button>
          
           
            <div className="container">
              
        <div className="left-column">
<img src={`http://localhost:5000/${product.name}.png`} alt=""/>
<img data-image="black" src="" alt=""></img>
<img data-image="blue" src="" alt=""></img>
<img data-image="red" className="active" src="" alt=""></img>
</div>



<div className="right-column">


<div className="product-description">
  <span> Жанрове : {tags.map(tag => (
     <div> {tag.name} </div>
   
  ))}
  </span>
  <h1>{product.name}</h1>
  <p>{product.description}</p>
</div>


<div className="product-configuration">

  
  <div className="product-color">
    

    
    <div className="product-quantity">
          Количество: <Select
          native
          value={product.quantity}
          onChange={(e) => {setQuantity(e.target.value)}}
          inputProps={{
            name: 'description',
            id: 'description-native-simple',
          }}
        >
         {[...Array(product.count_in_stock).keys()].map(instock=>
                        <option key={instock+1} value={instock + 1}>{instock+1}</option>  )}
        </Select> 
      </div>
  </div>
        
 
    </div>


    <div className="product-price">
     <span >Цена (1бр.) : {Number(product.price).toFixed(2)} лв.</span>
    
    </div>
    {product.count_in_stock > 0 &&  <Button
              style={{marginTop: 30}}
              variant="contained"
              color="primary"
              onClick={AddToCart}
              endIcon={<AddBoxIcon/>}
             >
                Добави в количката
            </Button>
      }
    </div>
    
    </div>
    );
           
           
          
           
        </div>
        
    );
}

export default withRouter(ProductDetailsPage);