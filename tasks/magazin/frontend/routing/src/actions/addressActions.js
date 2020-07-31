import axios from "axios";
import { ADDRESS_LIST_REQUEST, ADDRESS_LIST_SUCCESS, ADDRESS_LIST_FAIL } from "../constants/addressConstants";


const listAddresses = () => async (dispatch) => {
    try {
        dispatch({ type: ADDRESS_LIST_REQUEST });
        const { data } = await axios.get(`http://localhost:5000/api/addresses/all`);
        dispatch({ type: ADDRESS_LIST_SUCCESS, payload: data });    
      } catch (error) {
        dispatch({ type: ADDRESS_LIST_FAIL, payload: error.message });
      }
};

export {listAddresses};
