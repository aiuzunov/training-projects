import { ADDRESS_LIST_REQUEST, ADDRESS_LIST_SUCCESS, ADDRESS_LIST_FAIL } from "../constants/addressConstants";


function addressListReducer(state = { addresses: [] }, action) {
    switch (action.type) {
      case ADDRESS_LIST_REQUEST:
        return { loading: true, addresses: [] };
      case ADDRESS_LIST_SUCCESS:
        return { loading: false, addresses: action.payload };
      case ADDRESS_LIST_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  export { addressListReducer }
