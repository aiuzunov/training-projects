import Cookie from 'js-cookie';
import { USER_GET_REQUEST,USER_GET_SUCCESS,USER_GET_FAIL,USER_SIGNIN_FAIL, USER_SIGNIN_SUCCESS, USER_SIGNIN_REQUEST, USER_SIGNUP_FAIL, USER_SIGNUP_SUCCESS, USER_SIGNUP_REQUEST, USER_LOGOUT_REQUEST, USER_LOGOUT_SUCCESS, USER_LOGOUT_FAIL, USER_LIST_REQUEST, USER_LIST_SUCCESS, USER_LIST_FAIL } from '../constants/userConstants';
import Axios from 'axios';

const signin = (email,password) => async (dispatch) => {
    dispatch({type: USER_SIGNIN_REQUEST,payload:{email,password}});
    try {
        const {data} = await Axios.post(`/api/users/sign`,{email,password});
        dispatch({type: USER_SIGNIN_SUCCESS,payload:data});
        Cookie.set('userInfo', JSON.stringify(data));
    } catch (error) {
        dispatch({type: USER_SIGNIN_FAIL,payload: error.response.data.msg});
    }
}

const signup = (name,username,email,password,update,id) => async (dispatch) => {
    dispatch({type: USER_SIGNUP_REQUEST,payload:{name,username,email,password}});
    try {
    if(!update)
    {
        const {data} = await Axios.post(`/api/users/create`,{name,username,email,password});
        dispatch({type: USER_SIGNUP_SUCCESS,payload:data});
    }
    else{
        const {data} = await Axios.put(`/api/users/update`,{name,username,email,password,id});
        dispatch({type: USER_SIGNUP_SUCCESS,payload:data});
        Cookie.set('userInfo', JSON.stringify(data));
    }

    } catch (error) {
        dispatch({type: USER_SIGNUP_FAIL,payload: error.response.data.msg});
    }
}


const logout = () => async (dispatch) => {
    dispatch({type: USER_LOGOUT_REQUEST});
    try {
        dispatch({type: USER_LOGOUT_SUCCESS});
        Cookie.remove('userInfo');
    } catch (error) {
        dispatch({type: USER_LOGOUT_FAIL,payload: error.message});
    }
}

const listUsers = (filterObject) => async (dispatch) => {
    try {
        dispatch({ type: USER_LIST_REQUEST });
        const { data } = await Axios.post(`/api/users/get`,filterObject);
        dispatch({ type: USER_LIST_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: USER_LIST_FAIL, payload: error.message });
      }
};

const getUser = (id) => async (dispatch) => {
    try {
        console.log("User id:",id)
        dispatch({ type: USER_GET_REQUEST });
        const { data } = await Axios.get(`/api/users/info/${id}`);
        dispatch({ type: USER_GET_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: USER_GET_FAIL, payload: error.message });
      }
};


export {signin, signup,logout,listUsers,getUser}
