import React, { useEffect, useState } from 'react';
import { addToCart, removeFromCart, saveCartItem, deleteCartItem } from './actions/cartActions';
import { useDispatch, useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
import NavBar from './NavBar';
import { withRouter } from 'react-router-dom';
import DeleteIcon from '@material-ui/icons/RemoveShoppingCart';
import { Button, makeStyles, createMuiTheme, Select, InputLabel, FormControl, MenuItem } from '@material-ui/core';
import ArrowBackIcon from '@material-ui/icons/ArrowBack';
import StoreIcon from '@material-ui/icons/Store';
import PayPal from './PayPal';
import { listAddresses } from './actions/addressActions';


function Cart(props){
    const cart = useSelector(state => state.cart);
    const {cartItems} = cart;
    const productId = props.match.params.id;
    const [defAddress, setDefAddress] = useState('');
    const quantity = props.location.search ? Number(props.location.search.split("=")[1]) : 1;
    const addressesList = useSelector((state) => state.addressesList);
    const { addresses , loading: loadingAddresses, error: addressesError } = addressesList;  
    const dispatch = useDispatch();
    const userSignIn = useSelector(state=>state.userSignIn);
    const {userInfo} = userSignIn;
    const removeFromCartHandler = (productId) => {
        let product_id = productId;
        let user_id = userInfo.id;
        dispatch(removeFromCart(productId));
        dispatch(deleteCartItem({product_id,user_id}));

    }
    useEffect(()=>{
        dispatch(listAddresses(userInfo.id))
        console.log(defAddress)
        if(productId){
            let user_id = userInfo.id;
            let product_id = productId;
            dispatch(addToCart(productId, quantity));
            dispatch(saveCartItem({product_id,quantity,user_id}));


        }
    },[])

    const handleAddressChange = (event) => {
        setDefAddress(event.target.value);

      };
    const checkoutHandler = () => {
        props.history.push("/signin?redirect=shipping");
    };
    const handleQuantClick = (product_id,quantity) => {
        let user_id = userInfo.id;
        dispatch(addToCart(product_id,quantity ));
        dispatch(saveCartItem({product_id,quantity,user_id}));
    }
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
      <Select
      value={defAddress}
      onChange={handleAddressChange}
      displayEmpty
      inputProps={{ 'aria-label': 'Without label' }}
    >
      <MenuItem value="">
        <em>Избери адрес</em>
        </MenuItem>
        {addresses.map(address => (
           <MenuItem key={address.id} value={address.id}>{address.address}</MenuItem>
          
        ))}
    </Select>
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
          onChange={(e) => handleQuantClick(item.product,e.target.value)}
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
                 <div className="one-price">Единична цена: {Number(item.price).toFixed(2)} {item.currency_id}.</div>
                 <div className="total-price">Oбща сума: {(item.price*item.quantity).toFixed(2)} {item.currency_id}.</div>
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
                  
                {(cartItems.reduce((a,c)=>a +c.price*c.quantity,0)).toFixed(2)} EUR.
            </h3>

            {defAddress ? <PayPal  address_id={defAddress} cart_items={cartItems} user_id={userInfo.id} totalprice={(cartItems.reduce((a,c)=>a +c.price*c.quantity,0)).toFixed(2)}/>:<h3>Моля изберете адрес за доставка</h3>}
        </div>
        </div>
       

    );
}
export default withRouter(Cart);
