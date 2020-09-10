import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { settingsChange } from './actions/userActions';
import { Button } from '@material-ui/core';
import NavBar from './NavBar';



function LockSettings(props,{ match , history} ) {
    const [chance1,setChance1] = useState(0);
    const [chance2,setChance2] = useState(0);
    const [time1,setTime1] = useState(0);
    const [time2,setTime2] = useState(0);
    const changeSettings = useSelector(state=>state.changeSettings);
    const {userSettings, loading, error,success} = changeSettings;
    const dispatch = useDispatch();
    useEffect(() => {

    },[]);


   const submitInfo = (e) => {
       e.preventDefault();
       dispatch(settingsChange(chance1,chance2,time1,time2))

   };

    return(
        <div>
            <div>
            <form onSubmit={submitInfo}>
                <ul className="form-container">
                    <li>
                        <h2>Промени настройките</h2>
                    </li>

                    <li>
                        <label htmlFor="chances1">
                          Брой опити преди 1-во заключване
                        </label>
                        <input required type="number" name="chances1" id="chances1" onChange={(e) => setChance1(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="chances2">
                          Брой опити преди 2-ро заключване

                        </label>
                        <input required type="number" name="chances2" id="chances2" onChange={(e) => setChance2(e.target.value)}/>
                    </li>

                        <li>
                        <label htmlFor="time2">
                            Време до отключване на акаунта след (1-во заключване)
                            </label>
                          <input required type="number" name="time1" id="time1" onChange={(e) => setTime1(e.target.value)}/>
                      </li>

                        <li>
                            <label htmlFor="email">
                            Време до отключване на акаунта след (2-ро заключване)
                            </label>
                        <input required type="number" name="time2" id="time2" onChange={(e) => setTime2(e.target.value)}/>
                          </li>
                    <li>
                   <Button
                      type="submit"
                      variant="contained"
                      color="primary"
                      >
                          Промени
                       </Button>

                    </li>

                </ul>
            </form>
        </div>

        </div>

    );
}

export default LockSettings;
