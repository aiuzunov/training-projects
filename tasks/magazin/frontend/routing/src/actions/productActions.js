import { PRODUCT_LIST_SUCCESS, PRODUCT_LIST_FAIL, PRODUCT_LIST_REQUEST, PRODUCT_DETAILS_REQUEST, PRODUCT_DETAILS_SUCCESS, PRODUCT_DETAILS_FAIL } from "../constants/productConstants";
import axios from 'axios';
const listProducts = (searchid,renderstartid) => async (dispatch) => {
    try {
        if(searchid!=""){
        dispatch({ type: PRODUCT_LIST_REQUEST });
        const { data } = await axios.get(`http://localhost:5000/products/${renderstartid}/${searchid}`);
        dispatch({ type: PRODUCT_LIST_SUCCESS, payload: data });
        }
    else{
        dispatch({ type: PRODUCT_LIST_REQUEST });
        const { data } = await axios.get(`http://localhost:5000/products/${renderstartid}`);
        dispatch({ type: PRODUCT_LIST_SUCCESS, payload: data });
        }
      } catch (error) {
        dispatch({ type: PRODUCT_LIST_FAIL, payload: error.message });
      }
};

const detailsProduct = (productId) => async (dispatch) => {
    try {
        dispatch({type: PRODUCT_DETAILS_REQUEST, payload: productId});
        const {data} = await axios.get(`http://localhost:5000/product/${productId}`);
        dispatch({type: PRODUCT_DETAILS_SUCCESS, payload: data});
    } catch (error) {
        dispatch({ type: PRODUCT_DETAILS_FAIL, payload: error.message });
    }
}

export {listProducts};
export {detailsProduct};
