import {UPDATE_ROLE_FAIL,UPDATE_ROLE_REQUEST,UPDATE_ROLE_SUCCESS,EMPLOYEE_LIST_FAIL,EMPLOYEE_LIST_REQUEST,EMPLOYEE_LIST_SUCCESS, EMPLOYEE_SIGNIN_FAIL, EMPLOYEE_SIGNIN_SUCCESS, EMPLOYEE_SIGNIN_REQUEST, EMPLOYEE_SIGNUP_REQUEST, EMPLOYEE_SIGNUP_SUCCESS, EMPLOYEE_SIGNUP_FAIL } from "../constants/employeeConstants";

function employeeSignInReducer(state = {}, action) {
    switch (action.type) {
      case EMPLOYEE_SIGNIN_REQUEST:
        return { loading: true };
      case EMPLOYEE_SIGNIN_SUCCESS:
        return { loading: false, employeeInfo: action.payload };
      case EMPLOYEE_SIGNIN_FAIL:
        return { loading: false, error: action.payload };
      default: return state;
    }
  }


  function employeeSignUpReducer(state = {}, action) {
    switch (action.type) {
      case EMPLOYEE_SIGNUP_REQUEST:
        return { loading: true };
      case EMPLOYEE_SIGNUP_SUCCESS:
        return { loading: false, success:true};
      case EMPLOYEE_SIGNUP_FAIL:
        return { loading: false, error: action.payload };
      default: return state;
    }
  }

  function employeeListReducer(state = { employees: [] }, action) {
    switch (action.type) {
      case EMPLOYEE_LIST_REQUEST:
        return { loading: true, employees: [] };
      case EMPLOYEE_LIST_SUCCESS:
        return { loading: false, employees: action.payload };
      case EMPLOYEE_LIST_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  function roleUpdateReducer(state = { employee: {} }, action) {
      switch (action.type) {
        case UPDATE_ROLE_REQUEST:
          return { loading: true };
        case UPDATE_ROLE_SUCCESS:
          return { loading: false, success: true, employee: action.payload };
        case UPDATE_ROLE_FAIL:
          return { loading: false, error: action.payload };
        default:
          return state;
      }
    }

  export {employeeListReducer,employeeSignInReducer,employeeSignUpReducer,roleUpdateReducer}
