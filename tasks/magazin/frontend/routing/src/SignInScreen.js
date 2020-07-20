import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { signin } from './actions/userActions';



function SignInScreen({  match , history }) {
    const [username,setUsername] = useState('');
    const [email,setEmail] = useState('');
    const [password,setPassword] = useState('');
    const userSignIn = useSelector(state=>state.userSignIn);
    const {userInfo, loading, error} = userSignIn;
    const dispatch = useDispatch();
    
    useEffect(() => {
        console.log(userInfo,loading,error)
        if(userInfo){
            history.push('/');
        }

    },[userInfo]);
 
   const submitInfo = (e) => {
       e.preventDefault();
       dispatch(signin(email,password))
   };
 
    return(
        <div className="signinform">
            <form onSubmit={submitInfo}>
                <ul className="form-container">
                    <li>
                        <h2>Sign In</h2>
                    </li>
                    <li>
                        {loading && <div>Loading...</div>}
                        {error && <div>{error}</div>}
                    </li>
                    <li>
                        <label htmlFor="email">
                            Email
                        </label>
                        <input type="email" name="email" id="email" onChange={(e) => setEmail(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="password">
                            Password
                        </label>
                        <input type="password" name="password" id="password" onChange={(e) => setPassword(e.target.value)}/>
                    </li>
                    <li>
                        <button type="submit" className="button primary">Sign In</button>
                    </li>
                    <li>
                        Don't have an account?
                    </li>
                    <li>
                        <Link to="/signup" className="button secondary text-center"> 
                        Create a new account
                        </Link>
                    </li>
                </ul>
            </form>
        </div>
        
    );
}

export default SignInScreen;