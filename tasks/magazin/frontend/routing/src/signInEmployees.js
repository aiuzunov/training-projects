import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { Button } from '@material-ui/core';
import NavBar from './NavBar';
import { employeeSign } from './actions/employeeActions';



function SignInEmployees({  match , history }) {
    const [username,setUsername] = useState('');
    const [email,setEmail] = useState('');
    const [password,setPassword] = useState('');
    const employeeSignIn = useSelector(state=>state.employeeSignIn);
    const {employeeInfo, loading, error} = employeeSignIn;
    const dispatch = useDispatch();

    useEffect(() => {
        if(employeeInfo){
            history.push('/backoffice');
        }

    },[employeeInfo]);

   const submitInfo = (e) => {
       e.preventDefault();
       dispatch(employeeSign(email,password))
   };

    return(
        <div>
            <NavBar/>
            <div className="signinform">
            <form onSubmit={submitInfo}>
                <ul className="form-container">
                    <li>
                        <h2>Влез в акаунт</h2>
                    </li>
                    <li>
                        {loading && <div>Loading...</div>}
                        {error && <div>{error}</div>}
                    </li>
                    <li>
                        <label htmlFor="email">
                             Имейл адрес
                        </label>
                        <input type="email" name="email" id="email" onChange={(e) => setEmail(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="password">
                            Парола
                        </label>
                        <input type="password" name="password" id="password" onChange={(e) => setPassword(e.target.value)}/>
                    </li>
                    <li>
                    <Button
                    type="submit"
                    variant="contained"
                    color="primary"
                    >
                        Влизане
                     </Button>

                    </li>
                </ul>
            </form>
        </div>

        </div>

    );
}

export default SignInEmployees;
