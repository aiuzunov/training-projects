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
import ReactExport from "react-export-excel";

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
    const [groupBy, setGroupBy] = useState('');

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
    const ExcelFile = ReactExport.ExcelFile;
    const ExcelSheet = ReactExport.ExcelFile.ExcelSheet;
    const ExcelColumn = ReactExport.ExcelFile.ExcelColumn;
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
  const groupByOptions = [
    {
    id: 1,
    show: "Без Филтър",
    name: "",
  },
  {
    id: 2,
    show: "Месец",
    name: "MONTH",
  },
  {
    id: 3,
    show: "Година",
    name: "YEAR",
  },
  {
    id:4,
    show: "Потребител",
    name: "USER"
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
      dispatch(listIncomes({groupBy,from,to}));
    //dispatch(listSoldProducts({from,to}));
     dispatch(listRegisteredUsers({from,to}));

    //  dispatch(listBestSellers({from,to}));

  },[groupBy,monthId,props.registeredUsers,props.income,toDate,fromDate]);
    console.log(incomes.reduce((a,c)=>a + Number(c.price),0))
    console.log(incomes)
    return(
      <div>

        <div style={{marginLeft:"80px"}}>
          {incomeListPop ?
          <h2> Справка за поръчки</h2> : registeredUsersPop ?
          <h2> Справка за потребители</h2> : <div></div>}


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
          {incomeListPop ? <Select
    value={groupBy}
    onChange={updateGroupBy}
    displayEmpty
    inputProps={{ 'aria-label': 'Without label' }}
  >
      {groupByOptions.map(tag => (
         <MenuItem key={tag.id} value={tag.name}>{tag.show}</MenuItem>

      ))}
  </Select> : 1==1}
        </Grid>
      </MuiPickersUtilsProvider>

      </div>:<div></div>}


      {incomeListPop ? <div style={{marginLeft:"60px"}} className="product-list">
        <div>
        <ExcelFile element={<button style={{marginTop:"10px"}}>Експортирай данните</button>}>
               <ExcelSheet data={incomes} name="Orders">
                   <ExcelColumn label="Направена на" value="created"/>
                   <ExcelColumn label="Име на потребителя" value="name"/>
                   <ExcelColumn label="Потребителско име" value="username"/>
                   <ExcelColumn label="Имейл на потребителя" value="email"/>
                   <ExcelColumn label="Адрес за доставка" value="address"/>
                   <ExcelColumn label="Обща сума на поръчката" value="price"/>
                   <ExcelColumn label="Валута" value="currency"/>
                   <ExcelColumn label="Статус на поръчката" value="order_status"/>
                   <ExcelColumn label="Продукти" value="string_agg"/>
               </ExcelSheet>
           </ExcelFile>
           <h3 style={{marginTop:"10px"}}>Брой резултати отговарящи на търсенето: {incomes.length}</h3>
         </div>
             <table className="rtable">
              <thead>
                  <tr>
                    {groupBy != 'USER' ?
                      <th>
                      {groupBy == '' ? <div>Направена на</div> : groupBy == 'MONTH' ? <div> Месец </div> : groupBy =='YEAR' ? <div>Година</div> : <div></div>}
                      </th> : 1==1}
                      <th>
                        Име на потребителя
                      </th>
                      <th>
                        Потребителско име
                      </th>
                      <th>
                        Имейл на потребителя
                      </th>
                      {groupBy == '' ?
                      <th>
                        {groupBy == '' ? <div>Адрес за доставка</div> : 1==1}
                      </th> : 1==1}
                      <th>
                       Обща сума на поръчката

                      </th>
                      {groupBy == '' ?
                      <th>
                          Статус на поръчката
                      </th> : 1==1}
                      {groupBy == '' ?
                      <th>
                          Продукти
                      </th> : 1==1}
                  </tr>
              </thead>
              <tbody>
                  {incomes.map(order => (
                      <tr key={order.id}>
                      {groupBy != 'USER' ?
                      <td>
                      {groupBy=='' ? <div>{(order.created).split("T").join(" ").slice(0,-5)}</div> :  groupBy=='MONTH' ? months.map(month => (

                         month.id == order.date ? <div>
                             {month.id} ({month.name})
                         </div> : <div></div>

                       )):order.date}
                      </td> : 1==1}
                      <td>
                        {order.name}
                      </td>
                      <td>
                        {order.username}
                      </td>
                      <td>
                        {order.email}
                      </td>
                      {groupBy == '' ?
                      <td>
                        {order.address}
                      </td> : 1==2}
                      <td align="right">
                          {order.price} {order.currency}
                      </td>
                      {groupBy == '' ?
                      <td>
                      {order.order_status}
                      </td> : 1==1}
                      {groupBy == '' ?
                      <td>
                        {order.string_agg}
                      </td> : 1==1}


                  </tr>
                  ))}
                </tbody>
                <thead>
                    <tr>
                        <th>
                        </th>
                        <th>
                        </th>
                        <th>
                        </th>
                        <th>
                        </th>
                        {groupBy != 'USER' ?
                        <th>
                        </th>
                         : 1==1}
                        {groupBy != 'MONTH' && groupBy != 'YEAR' && groupBy != 'USER' ?
                        <th>
                        </th> : 1==1}
                        {groupBy != 'MONTH' && groupBy != 'YEAR' && groupBy != 'USER' ?
                        <th>
                        </th> : 1==1}
                        {groupBy != 'MONTH' && groupBy != 'YEAR' && groupBy != 'USER' ?
                        <th>
                        </th> : 1==1}
                    </tr>
                </thead>
                <tbody>
                  <tr>
                    <th>
                    Общo

                    </th>
                    {groupBy != 'MONTH' && groupBy != 'YEAR' && groupBy != 'USER' ?
                    <td>
                    </td> : 1==1 }
                    { groupBy != 'USER' ?
                    <td>
                    </td> : 1==1}
                    <td>
                    </td>
                    <td>
                    </td>
                    <td align="right">
                        {incomes.reduce((a,c)=>a + Number(c.price),0)} EUR
                    </td>
                    {groupBy != 'MONTH' && groupBy != 'YEAR' && groupBy != 'USER' ?
                    <td>
                    </td> : 1==1}
                    {groupBy != 'MONTH' && groupBy != 'YEAR' && groupBy != 'USER' ?
                    <td>
                    </td> : 1==1}
                  </tr>
                </tbody>

          </table>
      </div>: <div>  </div>}
      {registeredUsersPop ? <div style={{marginLeft:"60px"}} className="product-list">
        <div>
        <ExcelFile element={<button style={{marginTop:"10px"}}>Експортирай данните</button>}>
               <ExcelSheet data={regUsers} name="Users">
                   <ExcelColumn label="Дата на регистрация" value="create_date"/>
                   <ExcelColumn label="Име" value="name"/>
                   <ExcelColumn label="Потребителско име" value="username"/>
                   <ExcelColumn label="Имейл" value="email"/>
                   <ExcelColumn label="Потвърден" value={(col) => col.verified=='true' ? "Да" : "Не"}/>
               </ExcelSheet>
           </ExcelFile>
           <h3 style={{marginTop:"10px"}}>Брой потребители отговарящи на търсенето: {regUsers.length}</h3>
         </div>
          <table className="rtable">
              <thead>
                <tr>
                    <th>
                        Дата на регистрация
                    </th>
                    <th>
                        Име
                    </th>

                    <th>
                        Потребителско име
                    </th>
                    <th>
                        E-mail
                    </th>
                    <th>
                      Потвърден
                    </th>
                </tr>
              </thead>
              <tbody>
                {regUsers.map(user => (
                    <tr key={user.id}>
                    <td>
                        {(user.create_date).split("T").join(" ").slice(0,-5)}
                    </td>
                    <td>
                         {user.name}
                    </td>
                    <td>
                         {user.username}
                    </td>
                    <td>
                         {user.email}
                    </td>
                    <td>
                      {user.verified=='true' ? <div>Да</div> : <div>Не</div>}
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
