import {createStore , combineReducers, applyMiddleware, compose} from 'redux';
import { productListReducer, productDetailsReducer, productSaveReducer, productDeleteReducer } from './reducer/productReducers';
import thunk from 'redux-thunk';
import { cartReducer } from './reducer/cartReducers';
import Cookie from 'js-cookie';
import { userSignInReducer, userSignUpReducer, userLogoutReducer } from './reducer/userReducers';
import { tagListReducer } from './reducer/tagsReducers';
import { ptListReducer } from './reducer/ptReducers';
import { employeeSignInReducer } from './reducer/employeeReducers';
import { addressListReducer } from './reducer/addressReducers';

const cartItems = Cookie.getJSON('cartItems') || [];
const userInfo = Cookie.getJSON('userInfo') || null;
const employeeInfo = Cookie.getJSON('employeeInfo') || null;

const initialState = {cart: {cartItems},userSignIn: {userInfo}, employeeSignIn: {employeeInfo}};
const reducer = combineReducers({
    productList: productListReducer,
    productDetails: productDetailsReducer,
    cart: cartReducer,
    userSignIn: userSignInReducer,
    userLogOut: userLogoutReducer,
    userSignUp: userSignUpReducer,
    productSave: productSaveReducer,
    productDelete: productDeleteReducer,
    tagsList: tagListReducer,
    ptList: ptListReducer,
    employeeSignIn: employeeSignInReducer,
    addressesList: addressListReducer,
})

const composeEnhancer = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const store = createStore(
  reducer,
  initialState,
  composeEnhancer(applyMiddleware(thunk))
);

export default store;