import { REGUSERS_LIST_REQUEST,REGUSERS_LIST_SUCCESS,REGUSERS_LIST_FAIL,INCOMES_LIST_REQUEST, INCOMES_LIST_SUCCESS, INCOMES_LIST_FAIL,SOLDPRODUCTS_LIST_FAIL,SOLDPRODUCTS_LIST_REQUEST,SOLDPRODUCTS_LIST_SUCCESS } from "../constants/statsConstants";

function incomesListReducer(state = { incomes: [] }, action) {
    switch (action.type) {
      case INCOMES_LIST_REQUEST:
        return { loading: true, incomes: [] };
      case INCOMES_LIST_SUCCESS:
        return { loading: false, incomes: action.payload };
      case INCOMES_LIST_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

function soldProductsListReducer(state = { soldProducts: [] }, action) {
      switch (action.type) {
        case SOLDPRODUCTS_LIST_REQUEST:
          return { loading: true, soldProducts: [] };
        case SOLDPRODUCTS_LIST_SUCCESS:
          return { loading: false, soldProducts: action.payload };
        case SOLDPRODUCTS_LIST_FAIL:
          return { loading: false, error: action.payload };
        default:
          return state;
      }
    }

function registeredUsersListReducer(state = { regUsers: [] }, action) {
        switch (action.type) {
          case REGUSERS_LIST_REQUEST:
            return { loading: true, regUsers: [] };
          case REGUSERS_LIST_SUCCESS:
            return { loading: false, regUsers: action.payload };
          case REGUSERS_LIST_FAIL:
            return { loading: false, error: action.payload };
          default:
            return state;
        }
      }

  export { incomesListReducer,soldProductsListReducer,registeredUsersListReducer }
