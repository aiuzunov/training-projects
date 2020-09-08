import axios from "axios";
import { RP_UPDATE_FAIL,RP_UPDATE_REQUEST,RP_UPDATE_SUCCESS,RP_LIST_REQUEST, RP_LIST_SUCCESS, RP_LIST_FAIL } from "../constants/rpConstants";


const listRoles = () => async (dispatch) => {
    try {
        dispatch({ type: RP_LIST_REQUEST });
        const { data } = await axios.get(`/rp/get`);
        dispatch({ type: RP_LIST_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: RP_LIST_FAIL, payload: error.message });
      }
};


const updatePermissions = (role_id,perm_id,action) => async (dispatch) => {
    try {
        dispatch({ type: RP_UPDATE_REQUEST });
        const { data } = await axios.post(`/rp/update`,{role_id,perm_id,action});
        dispatch({ type: RP_UPDATE_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: RP_UPDATE_FAIL, payload: error.message });
      }
};

export {listRoles,updatePermissions};
