import Cookie from 'js-cookie';
import Axios from 'axios';
import { ADDRESS_SAVE_REQUEST, ADDRESS_SAVE_SUCCESS, ADDRESS_SAVE_FAIL } from '../constants/addressConstants';
import { UPDATE_STATUS_FAIL,UPDATE_STATUS_REQUEST,UPDATE_STATUS_SUCCESS,ORDER_SAVE_FAIL, ORDER_SAVE_SUCCESS, ORDER_SAVE_REQUEST, ORDER_LIST_REQUEST, ORDER_LIST_SUCCESS, ORDER_LIST_FAIL, ORDERITEMS_LIST_REQUEST, ORDERITEMS_LIST_SUCCESS, ORDERITEMS_LIST_FAIL, GET_ORDER_REQUEST, GET_ORDER_SUCCESS, GET_ORDER_FAIL } from '../constants/orderConstants';




const saveOrder = (order) => async (dispatch, getState) => {
    try {
      dispatch({ type: ORDER_SAVE_REQUEST, payload: order });
      const { data } = await Axios.post(`/orders/create`, order);
      dispatch({ type: ORDER_SAVE_SUCCESS, payload: data });
    } catch (error) {
      dispatch({ type: ORDER_SAVE_FAIL, payload: error.response.data.msg });
    }
  };

  const listOrders = (user_id,filterObject) => async (dispatch) => {
    try {
      if(!filterObject){
        dispatch({ type: ORDER_LIST_REQUEST });
        const { data } = await Axios.get(`/orders/list/${user_id}`);
        dispatch({ type: ORDER_LIST_SUCCESS, payload: data });
      }else{
        dispatch({ type: ORDER_LIST_REQUEST });
        const { data } = await Axios.post(`/orders/listall`,filterObject);
        dispatch({ type: ORDER_LIST_SUCCESS, payload: data });
      }

      } catch (error) {
        dispatch({ type: ORDER_LIST_FAIL, payload: error.response.data.msg });
      }
};

const getSingleOrder = (order_id) => async (dispatch) => {
  try {
      dispatch({ type: GET_ORDER_REQUEST });
      const { data } = await Axios.get(`/orders/order/${order_id}`);
      dispatch({ type: GET_ORDER_SUCCESS, payload: data });
    } catch (error) {
      dispatch({ type: GET_ORDER_FAIL, payload: error.response.data.msg });
    }
};



const updateStatus = (order_status,order_id) => async (dispatch) => {
  try {
      console.log(order_status,order_id)
      dispatch({ type: UPDATE_STATUS_REQUEST });
      const { data } = await Axios.post(`/orders/update`,{order_status,order_id});
      dispatch({ type: UPDATE_STATUS_SUCCESS, payload: data });
    } catch (error) {
      dispatch({ type: UPDATE_STATUS_FAIL, payload: error.response.data.msg });
    }
};

const listOrderItems = (order_id) => async (dispatch) => {
  try {
      dispatch({ type: ORDERITEMS_LIST_REQUEST });
      const { data } = await Axios.get(`/orders/listItems/${order_id}`);
      dispatch({ type: ORDERITEMS_LIST_SUCCESS, payload: data });
    } catch (error) {
      dispatch({ type: ORDERITEMS_LIST_FAIL, payload: error.response.data.msg });
    }
};

export { saveOrder,listOrders,listOrderItems,getSingleOrder,updateStatus }
