import { CART_ADD_ITEM, CART_REMOVE_ITEM, CARTITEM_SAVE_REQUEST, CARTITEM_SAVE_SUCCESS, CARTITEM_SAVE_FAIL, CARTITEM_DELETE_FAIL,CARTITEM_DELETE_REQUEST,CARTITEM_DELETE_SUCCESS } from "../constants/cartConstants"
import Cookie from "js-cookie";

const { default: Axios } = require("axios")

const addToCart = (productId, quantity)  => async (dispatch, getState) => {
        try {
            const { data } = await Axios.get(`/api/cart/${productId}`)
            dispatch({type: CART_ADD_ITEM, payload:{
                product: data.id,
                name: data.name,
                image: data.image,
                price: data.price,
                description: data.description,
                count_in_stock: data.count_in_stock,
                currency_id: data.currency_id,
                quantity
            }});
            const {cart:{cartItems}} = getState();
            Cookie.set("cartItems",JSON.stringify(cartItems));
        } catch (error) {
        }
    }
    export { addToCart }


    const saveCartItem = (cartItem) => async (dispatch, getState) => {
        try {

          dispatch({ type: CARTITEM_SAVE_REQUEST, payload: cartItem });
          const { data } = await Axios.post(`/api/cart/create`, cartItem);
          dispatch({ type: CARTITEM_SAVE_SUCCESS, payload: data });
        } catch (error) {
          dispatch({ type: CARTITEM_SAVE_FAIL, payload: error.response.data.msg });
        }
      };
    export {saveCartItem}

    const deleteCartItem = (cartItem) => async (dispatch, getState) => {
        try {
            console.log(cartItem)

            dispatch({type: CARTITEM_DELETE_REQUEST, payload: cartItem});
            const {data} = await Axios.post(`/api/cart/delete`,cartItem);
            dispatch({type: CARTITEM_DELETE_SUCCESS, payload: data, success: true});
        } catch (error) {
            dispatch({ type: CARTITEM_DELETE_FAIL, payload: error.message });
        }
      }
    export { deleteCartItem }
    
const removeFromCart =  (productId) => (dispatch, getState) =>{
    dispatch({type: CART_REMOVE_ITEM, payload: productId});
    const {cart:{cartItems}} = getState();
    Cookie.set("cartItems",JSON.stringify(cartItems));
}

export { removeFromCart }