import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { signin } from './actions/userActions';
import { Button } from '@material-ui/core';
import NavBar from './NavBar';
import Cookie from 'js-cookie';



function SignInScreen({  match , history }) {
    const [username,setUsername] = useState('');
    const [email,setEmail] = useState('');
    const [password,setPassword] = useState('');
    const userSignIn = useSelector(state=>state.userSignIn);
    const {userInfo, loading, error} = userSignIn;
    const dispatch = useDispatch();
   
    useEffect(() => {
        if(Cookie.getJSON('userInfo')){
            history.push("/")
        }

    },[userInfo]);
 
   const submitInfo = (e) => {
       e.preventDefault();
       dispatch(signin(email,password))
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
                    <li>
                        Нямаш акаунт?
                    </li>
                    <li>
                       
                        <Button
                    href="/signup"
                    variant="contained"
                    color="primary"
                    >
                        Създай нов акаунт
                     </Button>
                     
                    </li>
                </ul>
            </form>
        </div>
        
        </div>
        
    );
}

export default SignInScreen;