import { PT_LIST_REQUEST, PT_LIST_SUCCESS, PT_LIST_FAIL } from "../constants/ptConstants";

function ptListReducer(state = { pts: [] }, action) {
    switch (action.type) {
      case PT_LIST_REQUEST:
        return { loading: true, pts: [] };
      case PT_LIST_SUCCESS:
        return { loading: false, pts: action.payload };
      case PT_LIST_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  export { ptListReducer }
