import { CART_ADD_ITEM, CART_REMOVE_ITEM } from "../constants/cartConstants"
import Cookie from "js-cookie";

const { default: Axios } = require("axios")

const addToCart = (productId, quantity)  => async (dispatch, getState) => {
        try {
            const { data } = await Axios.get(`http://localhost:5000/api/cart/${productId}`)
            dispatch({type: CART_ADD_ITEM, payload:{
                product: data.id,
                name: data.name,
                image: data.image,
                price: data.price,
                description: data.description,
                count_in_stock: data.count_in_stock,
                quantity
            }});
            const {cart:{cartItems}} = getState();
            Cookie.set("cartItems",JSON.stringify(cartItems));
        } catch (error) {
            
        }
    }

    export { addToCart }


const removeFromCart =  (productId) => (dispatch, getState) =>{
    dispatch({type: CART_REMOVE_ITEM, payload: productId});
    const {cart:{cartItems}} = getState();
    Cookie.set("cartItems",JSON.stringify(cartItems));
}

export { removeFromCart }