import { PRODUCT_LIST_SUCCESS, PRODUCT_LIST_FAIL, PRODUCT_LIST_REQUEST, PRODUCT_DETAILS_REQUEST, PRODUCT_DETAILS_SUCCESS, PRODUCT_DETAILS_FAIL, PRODUCT_SAVE_REQUEST, PRODUCT_SAVE_SUCCESS, PRODUCT_SAVE_FAIL, PRODUCT_DELETE_REQUEST, PRODUCT_DELETE_SUCCESS, PRODUCT_DELETE_FAIL } from "../constants/productConstants";
import axios from 'axios';
const listProducts = (productFilters) => async (dispatch) => {
    try {
        dispatch({ type: PRODUCT_LIST_REQUEST });
        const { data } = await axios.post(`/products/getProducts`,productFilters);
        dispatch({ type: PRODUCT_LIST_SUCCESS, payload: data });

      } catch (error) {
        dispatch({ type: PRODUCT_LIST_FAIL, payload: error.message });
      }
};

const saveProduct = (product) => async (dispatch, getState) => {
    try {

      dispatch({ type: PRODUCT_SAVE_REQUEST, payload: product });
      const {
        employeeSignIn: { employeeInfo },
      } = getState();
      if(product.id){
        const { data } = await axios.put(`/products/update`, product, {
        headers: {
          Authorization: 'Bearer ' + employeeInfo.token,
        },
      });
      dispatch({ type: PRODUCT_SAVE_SUCCESS, payload: data });

    }else {
        const { data } = await axios.post(`/products/create`, product, {
            headers: {
              Authorization: 'Bearer ' + employeeInfo.token,
            },
          });
          dispatch({ type: PRODUCT_SAVE_SUCCESS, payload: data });
    }


    } catch (error) {
      dispatch({ type: PRODUCT_SAVE_FAIL, payload: error.message });
    }
  };

const detailsProduct = (productId) => async (dispatch) => {
    try {
        dispatch({type: PRODUCT_DETAILS_REQUEST, payload: productId});
        const {data} = await axios.get(`/products/get?id=${productId}`);
        console.log(data)
        dispatch({type: PRODUCT_DETAILS_SUCCESS, payload: data});
    } catch (error) {
        dispatch({ type: PRODUCT_DETAILS_FAIL, payload: error.message });
    }
}

const deleteProduct = (product) => async (dispatch, getState) => {
  try {
      dispatch({type: PRODUCT_DELETE_REQUEST, payload: product.id});
      const {
        employeeSignIn: { employeeInfo },
      } = getState();

      const {data} = await axios.delete(`/products/delete?id=${product.id}`,
      {
        headers:{
          Authorization: 'Bearer ' + employeeInfo.token
        }
      });
      dispatch({type: PRODUCT_DELETE_SUCCESS, payload: data, success: true});
  } catch (error) {
      dispatch({ type: PRODUCT_DELETE_FAIL, payload: error.message });
  }
}

export {listProducts};
export {detailsProduct};
export {saveProduct};
export {deleteProduct};
