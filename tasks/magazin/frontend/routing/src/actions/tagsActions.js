import axios from "axios";
import { TAG_LIST_REQUEST, TAG_LIST_SUCCESS, TAG_LIST_FAIL } from "../constants/tagsConstants";


const listTags = (id) => async (dispatch) => {
    try {
      if(id){
        dispatch({ type: TAG_LIST_REQUEST });
        const { data } = await axios.get(`/tags/getOne?id=${id}`);
        dispatch({ type: TAG_LIST_SUCCESS, payload: data });
      }
      else{
        console.log(id)
        console.log("test")
        dispatch({ type: TAG_LIST_REQUEST });
        const { data } = await axios.get(`/tags/getAll`);
        dispatch({ type: TAG_LIST_SUCCESS, payload: data });
      }
      } catch (error) {
        dispatch({ type: TAG_LIST_FAIL, payload: error.message });
      }
};

export {listTags};
