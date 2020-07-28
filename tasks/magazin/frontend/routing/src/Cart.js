import React, { useEffect } from 'react';
import { addToCart, removeFromCart } from './actions/cartActions';
import { useDispatch, useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
import NavBar from './NavBar';
import { withRouter } from 'react-router-dom';
import DeleteIcon from '@material-ui/icons/RemoveShoppingCart';
import { Button, makeStyles, createMuiTheme, Select, InputLabel, FormControl } from '@material-ui/core';
import ArrowBackIcon from '@material-ui/icons/ArrowBack';
import StoreIcon from '@material-ui/icons/Store';

function Cart(props){
    const cart = useSelector(state => state.cart);
    const {cartItems} = cart;
    const productId = props.match.params.id;
    const quantity = props.location.search ? Number(props.location.search.split("=")[1]) : 1;
    const dispatch = useDispatch();
    const removeFromCartHandler = (productId) => {
        dispatch(removeFromCart(productId))
    }
    useEffect(()=>{
        if(productId){
            console.log(productId, quantity)
            dispatch(addToCart(productId, quantity));

        }
    },[])
    
    const checkoutHandler = () => {
        props.history.push("/signin?redirect=shipping");
    };


    return(

        <div>
                 <NavBar/>

<div className="shopping-cart">

<div className="title">
<Button
        onClick={props.history.goBack}
        variant="contained"
        color="secondary"
        className="backButton"
        startIcon={<ArrowBackIcon />}
      >
        Продължи да пазаруваш
      </Button>
<h1>Количка с продукти</h1>
</div>
{
cartItems.length === 0 ? 
            <div className="title">
               <h3>Количката е празна</h3>
            </div>
            :
            cartItems.map(item => 
            <div className="item">
            <div className="buttons">
                <span className="delete-btn"></span>
                <span className="like-btn"></span>
            </div>

             <div className="image">
                  <img src={`http://localhost:5000/${item.name}.png`} alt="" />
            </div>
                
            <div className="description">
                  <span>{item.name}</span>
                 
              </div>


             <div className="quantity">
                    <FormControl >
        <InputLabel htmlFor="age-native-simple">Количество</InputLabel>
        <Select
          style={{minWidth: 70}}
          native
          value={item.quantity}
          onChange={(e) => dispatch(addToCart(item.product, e.target.value))}
          inputProps={{
            name: 'description',
            id: 'description-native-simple',
          }}
        >
         {[...Array(item.count_in_stock).keys()].map(instock=>
                        <option key={instock+1} value={instock + 1}>{instock+1}</option>  )}
        </Select>
      </FormControl>
            </div>
                 <div className="total-price">Единична цена: {Number(item.price).toFixed(2)} лв.</div>
                 <div className="total-price">Oбща сума: {(item.price*item.quantity).toFixed(2)} лв.</div>
                 <div className="item-remove">
                    <Button
                    onClick={() => removeFromCartHandler(item.product)}
                    variant="contained"
                    color="primary"
                    startIcon={<DeleteIcon />}>
                        Премахни
                     </Button>

                 </div>
                     
            </div>

          
            )
        }
         

</div>

<div className="cart-action">
            <h3>
                Общо ( {cartItems.reduce((a,c) => parseInt(a) + parseInt(c.quantity),0)} продукт/а )
                :
                  
                {(cartItems.reduce((a,c)=>a +c.price*c.quantity,0)).toFixed(2)} лв.
            </h3>
            <Button
                    onClick={checkoutHandler}
                    variant="contained"
                    color="secondary"
                    disabled={cartItems.length === 0}
                    startIcon={<StoreIcon />}>
                       Поръчай продуктите в количката
                     </Button>
        </div>
        </div>
       

    );
}
export default withRouter(Cart);
