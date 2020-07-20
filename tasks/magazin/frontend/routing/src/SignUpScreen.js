import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { signin, signup } from './actions/userActions';



function SignUpScreen({  match , history }) {
    const [name,setName] = useState('');
    const [username,setUsername] = useState('');
    const [email,setEmail] = useState('');
    const [password,setPassword] = useState('');
    const [password2,setPassword2] = useState('');
    const userSignUp = useSelector(state=>state.userSignIn);
    const {userInfo, loading, error} = userSignUp;
    const dispatch = useDispatch();
    
    useEffect(() => {
        console.log(userInfo,loading,error)
        if(userInfo){
            history.push('/');
        }

    },[userInfo]);
 
   const submitInfo = (e) => {
       e.preventDefault();
       dispatch(signup(name,username,email,password))
   };
 
    return(
        <div className="signinform">
            <form onSubmit={submitInfo}>
                <ul className="form-container">
                    <li>
                        <h2>Sign Up</h2>
                    </li>
                    <li>
                        {loading && <div>Loading...</div>}
                        {error && <div>{error}</div>}
                    </li>
                    <li>
                        <label htmlFor="name">
                            Name
                        </label>
                        <input type="name" name="name" id="name" onChange={(e) => setName(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="username">
                            Username
                        </label>
                        <input type="username" name="username" id="username" onChange={(e) => setUsername(e.target.value)}/>
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
                        <label htmlFor="password2">
                            Password
                        </label>
                        <input type="password" name="password2" id="password2" onChange={(e) => setPassword2(e.target.value)}/>
                    </li>
                    <li>
                        <Link to="/">
                        <button type="submit" className="button primary">Sign Up</button>
                        </Link>
                    </li>
                    <li>
                        Already have an account? <Link to="/signin">Sign In</Link>
                    </li>
                </ul>
            </form>
        </div>
        
    );
}

export default SignUpScreen;