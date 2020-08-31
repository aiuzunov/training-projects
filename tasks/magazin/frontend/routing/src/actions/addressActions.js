import axios from "axios";
import { ADDRESS_LIST_REQUEST, ADDRESS_LIST_SUCCESS, ADDRESS_LIST_FAIL, ADDRESS_SAVE_SUCCESS, ADDRESS_SAVE_REQUEST, ADDRESS_SAVE_FAIL, GET_ADDRESS_REQUEST, GET_ADDRESS_SUCCESS, GET_ADDRESS_FAIL } from "../constants/addressConstants";


const listAddresses = (userid) => async (dispatch) => {
    try {
        dispatch({ type: ADDRESS_LIST_REQUEST });
        const { data } = await axios.get(`/addresses/getAll?userid=${userid}`);
        dispatch({ type: ADDRESS_LIST_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: ADDRESS_LIST_FAIL, payload: error.response.data.msg });
      }
};

const listAddress = (order_id) => async (dispatch) => {
  try {
      console.log(order_id)
      dispatch({ type: GET_ADDRESS_REQUEST });
      const { data } = await axios.get(`/addresses/getOne?order_id=${order_id}`);
      dispatch({ type: GET_ADDRESS_SUCCESS, payload: data });
    } catch (error) {
      dispatch({ type: GET_ADDRESS_FAIL, payload: error.response.data.msg });
    }
};

const saveAddress = (address) => async (dispatch, getState) => {
  try {
    dispatch({ type: ADDRESS_SAVE_REQUEST, payload: address });
    const { data } = await axios.post(`/addresses/create`, address);
    dispatch({ type: ADDRESS_SAVE_SUCCESS, payload: data });
  } catch (error) {
    dispatch({ type: ADDRESS_SAVE_FAIL, payload: error.response.data.msg });
  }
};

export {listAddresses,saveAddress,listAddress};
