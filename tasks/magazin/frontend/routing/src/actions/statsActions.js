import axios from "axios";
import { REGUSERS_LIST_REQUEST,REGUSERS_LIST_SUCCESS,REGUSERS_LIST_FAIL,INCOMES_LIST_REQUEST, INCOMES_LIST_SUCCESS, INCOMES_LIST_FAIL,SOLDPRODUCTS_LIST_REQUEST,SOLDPRODUCTS_LIST_FAIL,SOLDPRODUCTS_LIST_SUCCESS } from "../constants/statsConstants";


const listIncomes = () => async (dispatch) => {
    try {
        dispatch({ type: INCOMES_LIST_REQUEST });
        const { data } = await axios.get(`/api/stats/monthlyIncome`);
        dispatch({ type: INCOMES_LIST_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: INCOMES_LIST_FAIL, payload: error.message });
      }
};

const listSoldProducts = () => async (dispatch) => {
    try {
        dispatch({ type: SOLDPRODUCTS_LIST_REQUEST });
        const { data } = await axios.get(`/api/stats/soldProducts`);
        dispatch({ type: SOLDPRODUCTS_LIST_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: SOLDPRODUCTS_LIST_FAIL, payload: error.message });
      }
};

const listRegisteredUsers = () => async (dispatch) => {
    try {
        dispatch({ type: REGUSERS_LIST_REQUEST });
        const { data } = await axios.get(`/api/stats/registeredUsers`);
        dispatch({ type: REGUSERS_LIST_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: REGUSERS_LIST_FAIL, payload: error.message });
      }
};

export {listIncomes,listSoldProducts,listRegisteredUsers};
