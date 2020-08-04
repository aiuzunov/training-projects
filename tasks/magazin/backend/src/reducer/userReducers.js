import { USER_SIGNIN_FAIL, USER_SIGNIN_SUCCESS, USER_SIGNIN_REQUEST, USER_SIGNUP_REQUEST, USER_SIGNUP_SUCCESS, USER_SIGNUP_FAIL, USER_LOGOUT_REQUEST, USER_LOGOUT_SUCCESS, USER_LOGOUT_FAIL } from "../constants/userConstants";

function userSignInReducer(state = {}, action) {
    switch (action.type) {
      case USER_SIGNIN_REQUEST:
        return { loading: true };
      case USER_SIGNIN_SUCCESS:
        return { loading: false, userInfo: action.payload };
      case USER_SIGNIN_FAIL:
        return { loading: false, error: action.payload };
      default: return state;
    }
  }

  function userSignUpReducer(state = {}, action) {
    switch (action.type) {
      case USER_SIGNUP_REQUEST:
        return { loading: true };
      case USER_SIGNUP_SUCCESS:
        return { loading: false};
      case USER_SIGNUP_FAIL:
        return { loading: false, error: action.payload };
      default: return state;
    }
  }

  function userLogoutReducer(state = {},action) {
    switch (action.type) {
      case USER_LOGOUT_REQUEST:
        return { loading:true };
      case USER_LOGOUT_SUCCESS:
        return {loading: false, userInfo: null};
      case USER_LOGOUT_FAIL:
        return {loading: false, error: action.payload};
      default: return state;
    }
  }

export {userSignInReducer,userSignUpReducer,userLogoutReducer};