import Cookie from 'js-cookie';
import { EMPLOYEE_SIGNIN_FAIL, EMPLOYEE_SIGNIN_SUCCESS, EMPLOYEE_SIGNIN_REQUEST } from '../constants/employeeConstants';
import Axios from 'axios';

const employeeSign = (email,password) => async (dispatch) => {
    dispatch({type: EMPLOYEE_SIGNIN_REQUEST,payload:{email,password}});
    try {
        const {data} = await Axios.post(`http://localhost:5000/api/employees/signemployee`,{email,password});
        dispatch({type: EMPLOYEE_SIGNIN_SUCCESS,payload:data});
        Cookie.set('employeeInfo', JSON.stringify(data));
    } catch (error) {
        dispatch({type: EMPLOYEE_SIGNIN_FAIL,payload: error.response.data.msg});
    }
}

export {employeeSign}