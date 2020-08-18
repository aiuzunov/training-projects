import Cookie from 'js-cookie';
import Axios from 'axios';
import { GET_PAYMENT_REQUEST, GET_PAYMENT_FAIL, GET_PAYMENT_SUCCESS } from '../constants/paymentConstants';

const getPayment = (order_id) => async (dispatch) => {
    try {
        dispatch({ type: GET_PAYMENT_REQUEST });
        const { data } = await Axios.get(`/api/payments/${order_id}`);
        dispatch({ type: GET_PAYMENT_SUCCESS, payload: data });    
      } catch (error) {
        dispatch({ type: GET_PAYMENT_FAIL, payload: error.response.data.msg });
      }
  };

export { getPayment}