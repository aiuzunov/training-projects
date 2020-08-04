import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link, useHistory } from 'react-router-dom';
import { signin, signup } from './actions/userActions';
import { Button, Typography } from '@material-ui/core';
import NavBar from './NavBar';
import Cookie from 'js-cookie';
import { employeeSignUp } from './actions/employeeActions';





function EmpSignUpScreen() {    
    const [name,setName] = useState('');
    const [username,setUsername] = useState('');
    const [email,setEmail] = useState('');
    const [password,setPassword] = useState('');
    const [password2,setPassword2] = useState('');
    const userSignUp = useSelector(state=>state.userSignUp);
    const {userInfo, loading, error} = userSignUp;
    const dispatch = useDispatch();
    const history = useHistory();

    useEffect(() => {

        if(loading==false&&error==undefined){
            setTimeout(
                () => window.location = "/manageproducts", 
                10000
              );
        }
    
        
        
    },[userInfo,loading]);
 

    

   const submitInfo = (e) => {
       if(password==password2){
        e.preventDefault();
        dispatch(employeeSignUp(name,username,email,password))

       }else{
           alert("Passwords must match")
       }
       
       
   };
 
    return(
        <div>
            <NavBar/>
            <div className="signinform">
            <form onSubmit={submitInfo}>
                <ul className="form-container">
                    <li>
                        <h2>Регистриране</h2>
                    </li>
                    <li>
                        {loading && <div>Loading...</div>}
                        {error && <div>{error}</div>}
                    </li>
                    <li>
                        <label htmlFor="name">
                            Име
                        </label>
                        <input required type="name" name="name" id="name" onChange={(e) => setName(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="username">
                            Потребителско име
                        </label>
                        <input required type="username" name="username" id="username" onChange={(e) => setUsername(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="email">
                            Имейл адрес
                        </label>
                        <input required type="email" name="email" id="email" onChange={(e) => setEmail(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="password">
                            Парола
                        </label>
                        <input required type="password" name="password" id="password" onChange={(e) => setPassword(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="password2">
                            Потвърдете паролата
                        </label>
                        <input required type="password" name="password2" id="password2" onChange={(e) => setPassword2(e.target.value)}/>
                    </li>
                    <li>
                    <Button 
                    type="submit"
                    variant="contained"
                    color="primary"
                    size="large"
                    >
                        Регистрация
                     </Button>
                    </li>
                    Вече имаш акаунт? 

                    <li>
                    <Button 
                    size="large"
                    href="/signin"
                    variant="contained"
                    color="primary"
                    >
                        Влез в твоя акаунт
                     </Button>
                     
                    </li>
                </ul>
            </form>
        </div>
        
        </div>
       
    );
}

export default EmpSignUpScreen;