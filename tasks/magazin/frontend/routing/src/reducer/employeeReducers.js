import { EMPLOYEE_SIGNIN_FAIL, EMPLOYEE_SIGNIN_SUCCESS, EMPLOYEE_SIGNIN_REQUEST, EMPLOYEE_SIGNUP_REQUEST, EMPLOYEE_SIGNUP_SUCCESS, EMPLOYEE_SIGNUP_FAIL } from "../constants/employeeConstants";

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

  export {employeeSignInReducer}