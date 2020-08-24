import {UPDATE_STATUS_FAIL,UPDATE_STATUS_REQUEST,UPDATE_STATUS_SUCCESS, ORDER_SAVE_REQUEST, ORDER_SAVE_SUCCESS, ORDER_SAVE_FAIL, ORDER_LIST_REQUEST, ORDER_LIST_SUCCESS, ORDER_LIST_FAIL, ORDERITEMS_LIST_REQUEST, ORDERITEMS_LIST_SUCCESS, ORDERITEMS_LIST_FAIL, GET_ORDER_REQUEST, GET_ORDER_SUCCESS, GET_ORDER_FAIL } from "../constants/orderConstants";

function orderSaveReducer(state = { order: {} }, action) {
    switch (action.type) {
      case ORDER_SAVE_REQUEST:
        return { loading: true };
      case ORDER_SAVE_SUCCESS:
        return { loading: false, success: true, order: action.payload };
      case ORDER_SAVE_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  function orderUpdateReducer(state = { order: {} }, action) {
      switch (action.type) {
        case UPDATE_STATUS_REQUEST:
          return { loading: true };
        case UPDATE_STATUS_SUCCESS:
          return { loading: false, success: true, order: action.payload };
        case UPDATE_STATUS_FAIL:
          return { loading: false, error: action.payload };
        default:
          return state;
      }
    }

function orderListReducer(state = { orders: [] }, action) {
    switch (action.type) {
      case ORDER_LIST_REQUEST:
        return { loading: true, orders: [] };
      case ORDER_LIST_SUCCESS:
        return { loading: false, orders: action.payload };
      case ORDER_LIST_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  function orderItemsListReducer(state = { orderItems: [] }, action) {
    switch (action.type) {
      case ORDERITEMS_LIST_REQUEST:
        return { loading: true, orderItems: [] };
      case ORDERITEMS_LIST_SUCCESS:
        return { loading: false, orderItems: action.payload };
      case ORDERITEMS_LIST_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  function getOrderReducer(state = { order: [] }, action) {
    switch (action.type) {
      case GET_ORDER_REQUEST:
        return { loading: true, order: [] };
      case GET_ORDER_SUCCESS:
        return { loading: false, order: action.payload };
      case GET_ORDER_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }


  export { orderUpdateReducer,orderSaveReducer,orderListReducer,orderItemsListReducer,getOrderReducer }
