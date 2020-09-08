import {RP_UPDATE_FAIL,RP_UPDATE_REQUEST,RP_UPDATE_SUCCESS, RP_LIST_REQUEST, RP_LIST_SUCCESS, RP_LIST_FAIL } from "../constants/rpConstants";

function rpListReducer(state = { rp: [] }, action) {
    switch (action.type) {
      case RP_LIST_REQUEST:
        return { loading: true, rp: [] };
      case RP_LIST_SUCCESS:
        return { loading: false, rp: action.payload };
      case RP_LIST_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  function rpUpdateReducer(state = { urp: {} }, action) {
      switch (action.type) {
        case RP_UPDATE_REQUEST:
          return { loading: true };
        case RP_UPDATE_SUCCESS:
          return { loading: false, success: true, urp: action.payload };
        case RP_UPDATE_FAIL:
          return { loading: false, error: action.payload };
        default:
          return state;
      }
    }

  export { rpListReducer,rpUpdateReducer }
