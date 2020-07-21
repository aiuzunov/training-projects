import axios from "axios";
import { TAG_LIST_REQUEST, TAG_LIST_SUCCESS, TAG_LIST_FAIL } from "../constants/tagsConstants";


const listTags = () => async (dispatch) => {
    try {
        dispatch({ type: TAG_LIST_REQUEST });
        const { data } = await axios.get(`http://localhost:5000/tags/all`);
        dispatch({ type: TAG_LIST_SUCCESS, payload: data });      
      } catch (error) {
        dispatch({ type: TAG_LIST_FAIL, payload: error.message });
      }
};

export {listTags};
