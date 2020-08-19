import React, { useEffect, useState } from 'react';
import NavBar from './NavBar';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listIncomes,listSoldProducts,listRegisteredUsers } from './actions/statsActions';
import { Checkbox, FormControlLabel, FormGroup, Select, Divider, makeStyles, FormControl, MenuItem, FormHelperText, FormLabel, RadioGroup, Radio, TextField, InputBase, Input, Typography, Slider } from '@material-ui/core';
import { Button, Icon, createMuiTheme } from '@material-ui/core';

const theme = createMuiTheme({
    palette: {
      primary: {
        light: '#428e92',
        main: '#005f63',
        dark: '#003539',
        contrastText: '#fff',
      },
    },
  });


function BackOfficeStats(){
    const [count, setCount] = useState([]);
    const [monthId,setMonthId] = useState([]);
    const [incomeListPop,setIncomeListPop] = useState(0);
    const [soldProductsPop,setSoldProductsPop] = useState(0);
    const [registeredUsersPop,setRegisteredUsersPop] = useState(0);
    const incomesList = useSelector((state) => state.incomesList);
    const { incomes , loading: incomesLoading, error:incomesError } = incomesList;
    const soldProductsList = useSelector((state) => state.soldProductsList);
    const { soldProducts , loading: soldProductsLoading, error:soldProductsError } = soldProductsList;
    const regUsersList = useSelector((state) => state.regUsersList);
    const { regUsers , loading: regUsersLoading, error:regUsersError } = regUsersList;
    const dispatch = useDispatch();
    const months = [{
      id: 1,
      name: "Януари"
    },
    {
      id: 2,
      name: "Февруари"
    },
    {
      id: 3,
      name: "Март"
    },
    {
      id: 4,
      name: "Април"
    },
    {
      id: 5,
      name: "Май"
    },
    {
      id: 6,
      name: "Юни"
    },
    {
      id: 7,
      name: "Юли"
    },
    {
      id: 8,
      name: "Август"
    },
    {
      id: 9,
      name: "Септември"
    },
    {
      id: 10,
      name: "Октомври"
    },
    {
      id: 11,
      name: "Ноември"
    },
    {
      id: 12,
      name: "Декември"
    }
  ];
  const handleMonthChange = (event) => {
    setMonthId(event.target.value);
  };

    useEffect(() => {
      dispatch(listIncomes({monthId}));
      dispatch(listSoldProducts({monthId}));
      dispatch(listRegisteredUsers({monthId}));
    },[monthId]);


    return(
      <div>
       <NavBar />
         <div className="categoryFilter">
         <Select
       multiple={true}
       autoWidth={true}
       value={monthId}
       onChange={handleMonthChange}
       displayEmpty
       inputProps={{ 'aria-label': 'Without label' }}
     >

         {months.map(month => (
            <MenuItem value={month.id}>{month.name}</MenuItem>
         ))}
     </Select>
     <FormHelperText>Филтрирай по месец</FormHelperText>
         </div>
         <div style={{marginTop: theme.spacing(10)}}className="content content-margined">
         <Button
             onClick={() =>  setIncomeListPop(!incomeListPop)}
             variant="contained"
             size="large"
             color="primary"
             style={{ marginRight: theme.spacing(2) }}
           >
             Приходи по месец
         </Button>
         <Button
             onClick={() => setSoldProductsPop(!soldProductsPop)}
             variant="contained"
             size="large"
             color="primary"
             style={{ marginRight: theme.spacing(2) }}

           >
            Продадени продукти
         </Button>
         <Button
             onClick={() => setRegisteredUsersPop(!registeredUsersPop)}
             variant="contained"
             size="large"
             color="primary"
             style={{ marginRight: theme.spacing(2) }}

           >
             Брой регистрации
         </Button>
       </div>

      {incomeListPop ? <div className="product-list">
        <h2> Приходи по месец</h2>
          <table className="table">
              <thead>
                  <tr>
                      <th>
                          Месец
                      </th>
                      <th>
                          Приходи
                      </th>


                  </tr>
              </thead>
              <tbody>
                  {incomes.map(income => (
                      <tr>
                      <td>
                          {income.month}
                      </td>
                      <td>
                           {income.sum} EUR
                      </td>
                  </tr>
                  ))}



              </tbody>
          </table>
      </div> : <div></div>}
      {soldProductsPop ? <div className="product-list">
          <h2> Общ брой продадени продукти</h2>
          <table className="table">
              <thead>
                  <tr>
                      <th>
                          Месец
                      </th>
                      <th>
                          Брой продадени продукти
                      </th>


                  </tr>
              </thead>
              <tbody>
                  {soldProducts.map(sp => (
                      <tr>
                      <td>
                          {sp.month}
                      </td>
                      <td>
                           {sp.sales}
                      </td>
                  </tr>
                  ))}



              </tbody>
          </table>
      </div> : <div></div>}
      {registeredUsersPop ? <div className="product-list">
        <h2> Общ брой регистрации</h2>
          <table className="table">
              <thead>
                  <tr>
                      <th>
                          Месец
                      </th>
                      <th>
                          Регистрирали се потребители
                      </th>


                  </tr>
              </thead>
              <tbody>
                  {regUsers.map(user => (
                      <tr>
                      <td>
                          {user.month}
                      </td>
                      <td>
                          {user.count}
                      </td>
                  </tr>
                  ))}



              </tbody>
          </table>
      </div>: <div></div>}
      </div>
    );
}



export default BackOfficeStats;
