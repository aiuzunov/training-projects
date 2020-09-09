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
    console.log(cartItems)
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
            <table style={{marginLeft:"5px"}}className="rtable">
            <thead>
            <tr>
              <th>Снимка</th>
              <th>Име</th>
              <th>Количество</th>
              <th>Единична цена</th>
              <th>Общо за продукта</th>

            </tr>
            </thead>
            <tbody>
            {cartItems.map(item =>
            <tr key={item.id}>
            <td className="item">
             <div className="image">
                  <img src={`/${item.name}.png`} alt="" />
            </div>
            </td>

            <td className="description">
                  {item.name}

              </td>


             <td align="right" className="quantity">
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
      </td>
                 <td align="right">{Number(item.price).toFixed(2)} {item.currency_id}</td>
                 <td align="right">{(item.price*item.quantity).toFixed(2)} {item.currency_id}</td>
                 <td>
                    <Button
                    onClick={() => removeFromCartHandler(item.product)}
                    variant="contained"
                    color="primary"
                    startIcon={<DeleteIcon />}>
                        Премахни
                     </Button>

                 </td>
            </tr>
            )
            }
            <tr>
            <th></th>
            <th></th>
            <th>Общ брой продукти</th>
            <th></th>

            <th>
              Общо за поръчката
            </th>
            </tr>
            <tr>
            <td></td>
            <td></td>
            <td align="right">{cartItems.reduce((a,c) => parseInt(a) + parseInt(c.quantity),0)} продукт/а</td>
            <td></td>

            <td align="right">

                            {(cartItems.reduce((a,c)=>a +c.price*c.quantity,0)).toFixed(2)} EUR

            </td>
            {props.isDisconnected ? <td>Няма връзка с интернет</td> :<td>
            { defAddress ? <PayPal  isDisconnected={props.isDisconnected} address_id={defAddress} cart_items={cartItems} user_id={userInfo.id} totalprice={(cartItems.reduce((a,c)=>a +c.price*c.quantity,0)).toFixed(2)}/>:<div>Моля изберете адрес за доставка</div>}

            </td> }

            </tr>
            </tbody>
            </table>

        }


</div>

        </div>


    );
}
export default withRouter(Cart);
