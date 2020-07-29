import React from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Route, Redirect } from 'react-router';


function PrivateRoute ({component: Component,...rest}) {
    const employeeSignIn = useSelector(state=>state.employeeSignIn);
    const {employeeInfo, loading, error} = employeeSignIn;
    const dispatch = useDispatch();
    return (
      <Route
        {...rest}
        render={(props) => employeeInfo
          ? <Component {...props} />
          : <Redirect to={{pathname: '/signinemp', state: {from: props.location}}} />}
      />
    )
  }

  export default PrivateRoute;