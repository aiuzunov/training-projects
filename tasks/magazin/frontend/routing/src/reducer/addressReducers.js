import { ADDRESS_LIST_REQUEST, ADDRESS_LIST_SUCCESS, ADDRESS_LIST_FAIL, ADDRESS_SAVE_REQUEST, ADDRESS_SAVE_FAIL, ADDRESS_SAVE_SUCCESS, GET_ADDRESS_FAIL, GET_ADDRESS_SUCCESS, GET_ADDRESS_REQUEST } from "../constants/addressConstants";


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


function singleAddressListReducer(state = { address: [] }, action) {
  switch (action.type) {
    case GET_ADDRESS_REQUEST:
      return { loading: true, address: [] };
    case GET_ADDRESS_SUCCESS:
      return { loading: false, address: action.payload };
    case GET_ADDRESS_FAIL:
      return { loading: false, error: action.payload };
    default:
      return state;
  }
}

  function addressSaveReducer(state = { address: {} }, action) {
    switch (action.type) {
      case ADDRESS_SAVE_REQUEST:
        return { loading: true, addresses: [] };
      case ADDRESS_SAVE_SUCCESS:
        return { loading: false, success: true, address: action.payload };
      case ADDRESS_SAVE_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  } 

  export { addressListReducer,addressSaveReducer,singleAddressListReducer }
