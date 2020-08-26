import React from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Route, Redirect } from 'react-router';


function CheckLoggedIn ({component: Component,...rest}) {
  const userSignIn = useSelector(state=>state.userSignIn);
  const {userInfo, loading, error} = userSignIn;
    const dispatch = useDispatch();
    return (
      <Route
        {...rest}
        render={(props) => userInfo
          ? <Component {...props} />
          : <Redirect to={{pathname: '/signin', state: {from: props.location}}} />}
      />
    )
  }

  export default CheckLoggedIn;
