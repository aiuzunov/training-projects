import Cookie from 'js-cookie';
import Axios from 'axios';
import { ADDRESS_SAVE_REQUEST, ADDRESS_SAVE_SUCCESS, ADDRESS_SAVE_FAIL } from '../constants/addressConstants';
import { ORDER_SAVE_FAIL, ORDER_SAVE_SUCCESS, ORDER_SAVE_REQUEST } from '../constants/orderConstants';


const saveOrder = (order) => async (dispatch, getState) => {
    try {
      console.log(order)
      dispatch({ type: ORDER_SAVE_REQUEST, payload: order });
      const { data } = await Axios.post(`http://localhost:5000/api/orders/create`, order);
      dispatch({ type: ORDER_SAVE_SUCCESS, payload: data });
    } catch (error) {
      dispatch({ type: ORDER_SAVE_FAIL, payload: error.response.data.msg });
    }
  };

export { saveOrder }