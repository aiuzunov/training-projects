import Cookie from 'js-cookie';
import {UPDATE_ROLE_FAIL,UPDATE_ROLE_REQUEST,UPDATE_ROLE_SUCCESS,EMPLOYEE_LIST_FAIL,EMPLOYEE_LIST_REQUEST,EMPLOYEE_LIST_SUCCESS, EMPLOYEE_SIGNIN_FAIL, EMPLOYEE_SIGNIN_SUCCESS, EMPLOYEE_SIGNIN_REQUEST, EMPLOYEE_SIGNUP_REQUEST, EMPLOYEE_SIGNUP_SUCCESS, EMPLOYEE_SIGNUP_FAIL } from '../constants/employeeConstants';
import Axios from 'axios';

const employeeSign = (email,password) => async (dispatch) => {
    dispatch({type: EMPLOYEE_SIGNIN_REQUEST,payload:{email,password}});
    try {
        const {data} = await Axios.post(`/employees/signemployee`,{email,password});
        dispatch({type: EMPLOYEE_SIGNIN_SUCCESS,payload:data});
        Cookie.set('employeeInfo', JSON.stringify(data));
    } catch (error) {
        dispatch({type: EMPLOYEE_SIGNIN_FAIL,payload: error.response.data.msg});
    }
}


const listEmployees = (filterObject) => async (dispatch) => {
    try {
        dispatch({ type: EMPLOYEE_LIST_REQUEST });
        const { data } = await Axios.post(`/employees/get`,filterObject);
        dispatch({ type: EMPLOYEE_LIST_SUCCESS, payload: data });
      } catch (error) {
        dispatch({ type: EMPLOYEE_LIST_FAIL, payload: error.message });
      }
};


const updateRole = (role_id,employee_id) => async (dispatch) => {
  try {
      dispatch({ type: UPDATE_ROLE_REQUEST });
      console.log(1)
      console.log(role_id,employee_id)
      const { data } = await Axios.post(`/employees/updateRole`,{role_id,employee_id});
      dispatch({ type: UPDATE_ROLE_SUCCESS, payload: data });
    } catch (error) {
      dispatch({ type: UPDATE_ROLE_FAIL, payload: error.response.data.msg });
    }
};

const employeesSignUp = (name,username,email,password,role_id,update,id) => async (dispatch) => {
    dispatch({type: EMPLOYEE_SIGNUP_REQUEST,payload:{name,username,email,password}});
    try {
      if(!update)
      {
          const {data} = await Axios.post(`/employees/createemployee`,{name,username,email,password,role_id});
          dispatch({type: EMPLOYEE_SIGNUP_SUCCESS,payload:data});
      }
      else{
          const {data} = await Axios.put(`/employees/updateEmployee`,{name,username,email,password,role_id,id});
          dispatch({type: EMPLOYEE_SIGNUP_SUCCESS,payload:data});
      }
    } catch (error) {
        dispatch({type: EMPLOYEE_SIGNUP_FAIL,payload: error.response.data.msg});
    }
}

export {employeeSign,employeesSignUp,listEmployees,updateRole}
