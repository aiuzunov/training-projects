import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { signin } from './actions/userActions';
import { Button } from '@material-ui/core';
import NavBar from './NavBar';
import Cookie from 'js-cookie';
import ReCAPTCHA from "react-google-recaptcha"



function SignInScreen(props,{ match , history} ) {
    const [username,setUsername] = useState('');
    const [email,setEmail] = useState('');
    const recaptchaRef = React.createRef();
    const [password,setPassword] = useState('');
    const [count,setCount] = useState(0);
    const userSignIn = useSelector(state=>state.userSignIn);
    const {userInfo, loading, error} = userSignIn;
    const dispatch = useDispatch();
    const [captchvalue,setCaptchValue]=useState('');
    useEffect(() => {
      getCount();

        if(Cookie.getJSON('userInfo')){
            props.history.push("/")
        }

    },[userInfo]);
    function onChange(value) {
      console.log("Captcha value:", value)
      setCaptchValue(value);
    }
    const getCount = async () => {
        try {
            const response = await fetch(
              `/orders/count`
            );
            const count = await response.json();
            console.log(count);
            setCount(count);
        } catch (err) {
          console.log(err.message);
        }
      };
      console.log(props)
   const submitInfo = (e) => {
       e.preventDefault();
       recaptchaRef.current.reset()
       dispatch(signin(captchvalue,email,password))
       setCaptchValue('')

   };
   console.log(captchvalue)

    return(
        <div>
          <div>
            Брой поръчки : {count.count}
          </div>
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
                        <input required type="email" name="email" id="email" onChange={(e) => setEmail(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="password">
                            Парола
                        </label>
                        <input required type="password" name="password" id="password" onChange={(e) => setPassword(e.target.value)}/>
                    </li>
                    <li>
                    <ReCAPTCHA ref={recaptchaRef} sitekey="6LfabMoZAAAAAFEunVzgVLF_WFS_Re3kFuT-AU_X" onChange={onChange} />
                    </li>
                    <li>
                    {!captchvalue || props.isDisconnected ?   <Button
                      disabled
                      type="submit"
                      variant="contained"
                      color="primary"
                      >
                          Влизане
                       </Button> :   <Button
                         type="submit"
                         variant="contained"
                         color="primary"
                         >
                             Влизане
                          </Button>}



                    </li>
                    <li>
                        Нямаш акаунт?
                    </li>
                    <li>
                    {props.isDisconnected ?     <Button
                    disabled
                    href="/signup"
                    variant="contained"
                    color="primary"
                    >
                        Създай нов акаунт
                     </Button>
 :     <Button
 href="/signup"
 variant="contained"
 color="primary"
 >
     Създай нов акаунт
  </Button>
}

                    </li>
                </ul>
            </form>
        </div>

        </div>

    );
}

export default SignInScreen;
