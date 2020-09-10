import {createStore , combineReducers, applyMiddleware, compose} from 'redux';
import { productListReducer, productDetailsReducer, productSaveReducer, productDeleteReducer } from './reducer/productReducers';
import thunk from 'redux-thunk';
import { cartReducer, CartItemSaveReducer, CartItemDeleteReducer } from './reducer/cartReducers';
import Cookie from 'js-cookie';
import {userSettingsReducer, userSignInReducer,userGetReducer, userSignUpReducer, userLogoutReducer, userListReducer } from './reducer/userReducers';
import { tagListReducer } from './reducer/tagsReducers';
import { rpUpdateReducer,rpListReducer } from './reducer/rpReducers';
import { ptListReducer } from './reducer/ptReducers';
import {roleUpdateReducer,employeeListReducer,employeeSignInReducer, employeeSignUpReducer } from './reducer/employeeReducers';
import { addressListReducer, addressSaveReducer, singleAddressListReducer } from './reducer/addressReducers';
import {orderUpdateReducer, orderSaveReducer, orderListReducer, orderItemsListReducer, getOrderReducer } from './reducer/orderReducers';
import { getPaymentReducer } from './reducer/paymentReducers';
import { bestSellersListReducer,incomesListReducer,soldProductsListReducer,registeredUsersListReducer } from './reducer/statsReducers';

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
    rpList: rpListReducer,
    employeeSignIn: employeeSignInReducer,
    addressesList: addressListReducer,
    addressSave: addressSaveReducer,
    cartSave: CartItemSaveReducer,
    cartDelete: CartItemDeleteReducer,
    employeeSignUp: employeeSignUpReducer,
    orderSave: orderSaveReducer,
    ordersList: orderListReducer,
    orderItemsList: orderItemsListReducer,
    getOrder: getOrderReducer,
    addressList: singleAddressListReducer,
    singlePaymentList: getPaymentReducer,
    usersList: userListReducer,
    incomesList: incomesListReducer,
    soldProductsList: soldProductsListReducer,
    regUsersList: registeredUsersListReducer,
    userGetInfo: userGetReducer,
    updateStatus: orderUpdateReducer,
    updateRole: roleUpdateReducer,
    updatePermission: rpUpdateReducer,
    bestSellersList: bestSellersListReducer,
    employeesList: employeeListReducer,
    changeSettings: userSettingsReducer,
})

const composeEnhancer = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;
const store = createStore(
  reducer,
  initialState,
  composeEnhancer(applyMiddleware(thunk))
);

export default store;
