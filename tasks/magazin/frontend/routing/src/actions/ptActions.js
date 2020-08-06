import axios from "axios";
import { PT_LIST_REQUEST, PT_LIST_SUCCESS, PT_LIST_FAIL } from "../constants/ptConstants";


const listPT = (pageNumber) => async (dispatch) => {
    try {
        dispatch({ type: PT_LIST_REQUEST });
        const { data } = await axios.post(`http://localhost:5000/api/pts/list/${pageNumber}`);
        dispatch({ type: PT_LIST_SUCCESS, payload: data });  
      } catch (error) {
        dispatch({ type: PT_LIST_FAIL, payload: error.message });
      }
};

export {listPT};
