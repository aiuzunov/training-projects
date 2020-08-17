import { USER_SIGNIN_FAIL, USER_SIGNIN_SUCCESS, USER_SIGNIN_REQUEST, USER_SIGNUP_REQUEST, USER_SIGNUP_SUCCESS, USER_SIGNUP_FAIL, USER_LOGOUT_REQUEST, USER_LOGOUT_SUCCESS, USER_LOGOUT_FAIL, USER_LIST_REQUEST, USER_LIST_SUCCESS, USER_LIST_FAIL } from "../constants/userConstants";

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
        return { loading: false,success: true};
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


function userListReducer(state = { users: [] }, action) {
  switch (action.type) {
    case USER_LIST_REQUEST:
      return { loading: true, users: [] };
    case USER_LIST_SUCCESS:
      return { loading: false, users: action.payload };
    case USER_LIST_FAIL:
      return { loading: false, error: action.payload };
    default:
      return state;
  }
}


export {userSignInReducer,userSignUpReducer,userLogoutReducer,userListReducer};