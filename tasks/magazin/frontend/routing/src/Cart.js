import React, { useEffect } from 'react';
import { addToCart, removeFromCart } from './actions/cartActions';
import { useDispatch, useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
import NavBar from './NavBar';
import { withRouter } from 'react-router-dom';


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
            dispatch(addToCart(productId, quantity));

        }
    },[])
    
    const checkoutHandler = () => {
        props.history.push("/signin?redirect=shipping");
    };
    
    return (
    <div>
         <NavBar/>
    <div className="cart">   
        <div className="cart-list">
            <ul className="cart-list-container">
            <button onClick={props.history.goBack}>Go back</button>     
                <li>
                    <h3>
                        Shopping Cart
                    </h3>                
                    <div>
                        Price
                    </div>
                 </li>
                {
                    cartItems.length === 0 ? 
                    <div>
                        Cart is empty
                    </div>
                    :
                    cartItems.map(item => 
                    <li>
                    <div className="cart-image">
                        <img src={item.image} alt="product" />
                    </div>
                    <div className="cart-name">
                        <div>
                            <Link to={`/product/${item.product}`}>
                            {item.name}
                            </Link>
                        </div>
                        <div>
                            <select value={item.quantity} onChange={(e) => dispatch(addToCart(item.product, e.target.value))}>
                            {[...Array(item.count_in_stock).keys()].map(instock=>
                                <option key={instock+1} value={instock + 1}>{instock+1}</option>  )}
                            </select>
                            <button type="button" className="button" onClick={() => removeFromCartHandler(item.product)} >
                                Remove
                            </button>
                        </div>
                        <div>
                            {item.price}
                        </div>
                    </div>
                    </li>
                    )
                }

            </ul>
        </div>
        <div className="cart-action">
            <h3>
                Subtotal ( {cartItems.reduce((a,c) => parseInt(a) + parseInt(c.quantity),0)} items )
                : 
                {(cartItems.reduce((a,c)=>a +c.price*c.quantity,0)).toFixed(2)} лв.
            </h3>
            <button onClick={checkoutHandler} className="button primary full-width" disabled={cartItems.length === 0}>
                Proceed to Checkout
            </button>
           
        </div>
    </div>
    </div>
   
    );
}

export default withRouter(Cart);