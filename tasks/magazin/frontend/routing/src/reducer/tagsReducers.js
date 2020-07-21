const { TAG_LIST_REQUEST, TAG_LIST_SUCCESS, TAG_LIST_FAIL } = require("../constants/tagsConstants");


function tagListReducer(state = { tags: [] }, action) {
    switch (action.type) {
      case TAG_LIST_REQUEST:
        return { loading: true, tags: [] };
      case TAG_LIST_SUCCESS:
        return { loading: false, tags: action.payload };
      case TAG_LIST_FAIL:
        return { loading: false, error: action.payload };
      default:
        return state;
    }
  }

  export { tagListReducer }
