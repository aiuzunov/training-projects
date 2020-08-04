import axios from "axios";
import { ADDRESS_LIST_REQUEST, ADDRESS_LIST_SUCCESS, ADDRESS_LIST_FAIL, ADDRESS_SAVE_SUCCESS, ADDRESS_SAVE_REQUEST, ADDRESS_SAVE_FAIL } from "../constants/addressConstants";


const listAddresses = (userid) => async (dispatch) => {
    try {
        dispatch({ type: ADDRESS_LIST_REQUEST });
        const { data } = await axios.get(`http://localhost:5000/api/addresses/all/${userid}`);
        dispatch({ type: ADDRESS_LIST_SUCCESS, payload: data });    
      } catch (error) {
        dispatch({ type: ADDRESS_LIST_FAIL, payload: error.response.data.msg });
      }
};


const saveAddress = (address) => async (dispatch, getState) => {
  try {
    dispatch({ type: ADDRESS_SAVE_REQUEST, payload: address });
    const { data } = await axios.post(`http://localhost:5000/api/addresses/create`, address);
    dispatch({ type: ADDRESS_SAVE_SUCCESS, payload: data });
  } catch (error) {
    dispatch({ type: ADDRESS_SAVE_FAIL, payload: error.response.data.msg });
  }
};

export {listAddresses,saveAddress};
