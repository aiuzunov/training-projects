import { CART_ADD_ITEM, CART_REMOVE_ITEM, CARTITEM_SAVE_SUCCESS, CARTITEM_SAVE_REQUEST, CARTITEM_SAVE_FAIL, CARTITEM_DELETE_REQUEST, CARTITEM_DELETE_FAIL, CARTITEM_DELETE_SUCCESS } from "../constants/cartConstants";

function cartReducer(state={cartItems:[]}, action){
    switch(action.type){
        case CART_ADD_ITEM:
            const item = action.payload;
            const product = state.cartItems.find(x=>x.product === item.product);
            if(product){
              return {cartItems :state.cartItems.map(x=>x.product=== product.product?item:x)};
            }
            return {cartItems: [...state.cartItems, item]};
        case CART_REMOVE_ITEM:
         return{ cartItems: state.cartItems.filter(x=>x.product !== action.payload)};
        default:
            return state;

    }
}

function CartItemSaveReducer(state = { cartItem: {} }, action) {
    switch (action.type) {
        case CARTITEM_SAVE_REQUEST:
            return { loading: true, cartItems: []  };
        case CARTITEM_SAVE_SUCCESS:
            return { loading: false, success: true, cartItem: action.payload };
        case CARTITEM_SAVE_FAIL:
            return { loading: false, error: action.payload };
      default:
        return state;
    }
  } 

function CartItemDeleteReducer(state = { cartItem: {} }, action) {
    switch (action.type) {
      case CARTITEM_DELETE_REQUEST:
        return { loading: true, cartItems: [] };
      case CARTITEM_DELETE_SUCCESS:
        return { loading: false, success: true, cartItem: action.payload };
      case CARTITEM_DELETE_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  } 



export { cartReducer , CartItemSaveReducer,CartItemDeleteReducer}