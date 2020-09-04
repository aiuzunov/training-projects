import React, { useEffect, useState } from 'react';
import NavBar from './NavBar';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listBestSellers,listIncomes,listSoldProducts,listRegisteredUsers } from './actions/statsActions';
import { Checkbox, FormControlLabel, FormGroup, Select, Divider, makeStyles, FormControl, MenuItem, FormHelperText, FormLabel, RadioGroup, Radio, TextField, InputBase, Input, Typography, Slider } from '@material-ui/core';
import { Button, Icon, createMuiTheme } from '@material-ui/core';
import 'date-fns';
import Grid from '@material-ui/core/Grid';
import DateFnsUtils from '@date-io/date-fns';
import {
  MuiPickersUtilsProvider,
  KeyboardTimePicker,
  KeyboardDatePicker,
} from '@material-ui/pickers';

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


function BackOfficeStats(props){
    const [count, setCount] = useState([]);
    const [monthId,setMonthId] = useState([]);
    const [incomeListPop,setIncomeListPop] = useState(0);
    const [bestSellersPop,setBestSellersPop] = useState(0);
    const [soldProductsPop,setSoldProductsPop] = useState(0);
    const [registeredUsersPop,setRegisteredUsersPop] = useState(0);
    const incomesList = useSelector((state) => state.incomesList);
    const { incomes , loading: incomesLoading, error:incomesError } = incomesList;
    const soldProductsList = useSelector((state) => state.soldProductsList);
    const { soldProducts , loading: soldProductsLoading, error:soldProductsError } = soldProductsList;
    const bestSellersList = useSelector((state) => state.bestSellersList);
    const { bestSellers , loading: bestSellersLoading, error:bestSellersError } = bestSellersList;
    const regUsersList = useSelector((state) => state.regUsersList);
    const { regUsers , loading: regUsersLoading, error:regUsersError } = regUsersList;
    const dispatch = useDispatch();
    const [groupBy, setGroupBy] = useState('DATE');

    const [fromDate, setFromDate] =  React.useState(new Date('2014-08-18T21:11:54'));
    const [toDate, setToDate] =  React.useState(new Date('2021-08-18T21:11:54'));
    const handleFromDateChange = (date) => {
      setFromDate(date);
    };
    const handleToDateChange = (date) => {
      setToDate(date);
    };
    console.log(bestSellers)
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
  const groupByOptions = [{
    id: 1,
    show: "Месец",
    name: "MONTH",
  },
  {
    id: 2,
    show: "Година",
    name: "YEAR",
  },
  {
    id:3,
    show: "Ден",
    name: "DATE"
  }
  ];
  const handleMonthChange = (event) => {
    setMonthId(event.target.value);
  };
  const updateGroupBy = e => {
    setGroupBy(e.target.value);
  }


    useEffect(() => {
      var from = fromDate.toLocaleString('en-GB', { timeZone: 'UTC' });
      var to = toDate.toLocaleString('en-GB', { timeZone: 'UTC' });
      setIncomeListPop(props.income);
      setRegisteredUsersPop(props.registeredUsers);
      setSoldProductsPop(props.soldProducts);
      setBestSellersPop(props.bestSellers);
      dispatch(listIncomes({monthId,from,to,groupBy}));
      dispatch(listSoldProducts({monthId,from,to,groupBy}));
      dispatch(listRegisteredUsers({monthId,from,to,groupBy}));
      dispatch(listBestSellers({monthId,from,to,groupBy}));
      console.log(bestSellersPop,soldProductsPop)

    },[monthId,props.bestSellers,props.soldProducts,props.registeredUsers,props.income,toDate,fromDate,groupBy]);
    console.log(bestSellers)
    return(
      <div>

        <div style={{marginLeft:"80px"}}>
          {incomeListPop ?
          <h2> Приходи от поръчки</h2> : soldProductsPop ?
          <h2> Общ брой продадени продукти</h2> : registeredUsersPop ?
          <h2> Общ брой регистрации</h2> : bestSellersPop ? <h2>Бестселъри</h2> : <div></div>}


        </div>
        {(soldProductsPop || registeredUsersPop || incomeListPop || bestSellersPop) ? <div>
          <MuiPickersUtilsProvider utils={DateFnsUtils}>
        <Grid container justify="start">
          <KeyboardDatePicker
            style={{marginLeft:"100px",marginRight:"50px"}}
            margin="normal"
            id="date-picker-dialog"
            label="ОТ-ДАТА"
            format="dd/MM/yyyy"
            value={fromDate}
            onChange={handleFromDateChange}
            KeyboardButtonProps={{
              'aria-label': 'change date',
            }}
          />
        <KeyboardDatePicker
          style={{marginRight:"50px"}}

            margin="normal"
            id="date-picker-dialog"
            label="ДО–ДАТА"
            format="dd/MM/yyyy"
            value={toDate}
            onChange={handleToDateChange}
            KeyboardButtonProps={{
              'aria-label': 'change date',
            }}
          />
          <Select
        value={groupBy}
        onChange={updateGroupBy}
        displayEmpty
        inputProps={{ 'aria-label': 'Without label' }}
      >
          {groupByOptions.map(tag => (
             <MenuItem key={tag.id} value={tag.name}>{tag.show}</MenuItem>

          ))}
      </Select>
        </Grid>
      </MuiPickersUtilsProvider></div>:<div></div>}


      {incomeListPop ? <div className="product-list">

          <table className="table">
              <thead>
                  <tr>
                      <th>
                      {groupBy=='DATE' ? <div>Дата</div> : groupBy=='MONTH' ? <div>Месец</div> : <div>Година</div>}

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
                      {groupBy=='MONTH' ? months.map(month => (

                         month.id == income.date ? <div>
                             {month.id} ({month.name})
                         </div> : <div></div>

                       )):income.date}
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
          <table className="table">
              <thead>
                  <tr>
                      <th>
                      {groupBy=='DATE' ? <div>Дата</div> : groupBy=='MONTH' ? <div>Месец</div> : <div>Година</div>}
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
                      {groupBy=='MONTH' ? months.map(month => (

                         month.id == sp.date ? <div>
                             {month.id} ({month.name})
                         </div> : <div></div>

                       )):sp.date}
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
          <table className="table">
              <thead>
                  <tr>
                      <th>
                          {groupBy=='DATE' ? <div>Дата</div> : groupBy=='MONTH' ? <div>Месец</div> : <div>Година</div>}
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
                      {groupBy=='MONTH' ? months.map(month => (

                         month.id == user.date ? <div>
                             {month.id} ({month.name})
                         </div> : <div></div>

                       )):user.date}

                      </td>
                      <td>
                          {user.count}
                      </td>
                  </tr>
                  ))}
              </tbody>
          </table>
      </div>: <div></div>}
      {bestSellersPop ? <div className="product-list">
          <table className="table">
              <thead>
                  <tr>
                      <th>
                      {groupBy=='DATE' ? <div>Дата</div> : groupBy=='MONTH' ? <div>Месец</div> : <div>Година</div>}
                      </th>
                      <th>
                          Име на продукта
                      </th>
                      <th>
                          Брой продажби
                      </th>


                  </tr>
              </thead>
              <tbody>
                  {bestSellers.map(sp => (
                      <tr>
                      <td>
                      {groupBy=='MONTH' ? months.map(month => (

                         month.id == sp.date ? <div>
                             {month.id} ({month.name})
                         </div> : <div></div>

                       )): groupBy == "YEAR" ? sp.date : sp.substring}
                      </td>
                      <td>
                           {sp.name}
                      </td>
                      <td>
                           {sp.total}
                      </td>
                  </tr>
                  ))}



              </tbody>
          </table>
      </div> : <div></div>}
      </div>
    );
}



export default BackOfficeStats;
