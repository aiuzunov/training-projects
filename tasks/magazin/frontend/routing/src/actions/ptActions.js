import axios from "axios";
import { PT_LIST_REQUEST, PT_LIST_SUCCESS, PT_LIST_FAIL } from "../constants/ptConstants";


const listPT = (filters) => async (dispatch) => {
    try {
        console.log(filters)
        dispatch({ type: PT_LIST_REQUEST });
        const { data } = await axios.post(`/api/pts/list/`,filters);
        dispatch({ type: PT_LIST_SUCCESS, payload: data });  
      } catch (error) {
        dispatch({ type: PT_LIST_FAIL, payload: error.message });
      }
};

export {listPT};
