const { GET_PAYMENT_REQUEST, GET_PAYMENT_SUCCESS, GET_PAYMENT_FAIL } = require("../constants/paymentConstants");

function getPaymentReducer(state = { payment: [] }, action) {
    switch (action.type) {
      case GET_PAYMENT_REQUEST:
        return { loading: true, payment: [] };
      case GET_PAYMENT_SUCCESS:
        return { loading: false, payment: action.payload };
      case GET_PAYMENT_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  export {getPaymentReducer}