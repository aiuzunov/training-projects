import Cookie from 'js-cookie';
import { USER_SIGNIN_FAIL, USER_SIGNIN_SUCCESS, USER_SIGNIN_REQUEST, USER_SIGNUP_FAIL, USER_SIGNUP_SUCCESS, USER_SIGNUP_REQUEST } from '../constants/userConstants';
import Axios from 'axios';

const signin = (email,password) => async (dispatch) => {
    dispatch({type: USER_SIGNIN_REQUEST,payload:{email,password}});
    try {
        const {data} = await Axios.post(`http://localhost:5000/signin`,{email,password});
        dispatch({type: USER_SIGNIN_SUCCESS,payload:data});
        Cookie.set('userInfo', JSON.stringify(data));
    } catch (error) {
        dispatch({type: USER_SIGNIN_FAIL,payload: error.message});
    }
}

const signup = (name,username,email,password,update) => async (dispatch) => {
    dispatch({type: USER_SIGNUP_REQUEST,payload:{name,username,email,password}});
    try {
    if(!update)
    {
        const {data} = await Axios.post(`http://localhost:5000/createuser`,{name,username,email,password});
        dispatch({type: USER_SIGNUP_SUCCESS,payload:data});
        Cookie.set('userInfo', JSON.stringify(data));
    }
    else{
        const {data} = await Axios.put(`http://localhost:5000/updateuser`,{name,username,email,password});
        dispatch({type: USER_SIGNUP_SUCCESS,payload:data});
        console.log(data);
        if(data.id){
            Cookie.set('userInfo', JSON.stringify(data));
        }
    }
        
    } catch (error) {
        dispatch({type: USER_SIGNUP_FAIL,payload: error.message});
    }
}



export {signin, signup}