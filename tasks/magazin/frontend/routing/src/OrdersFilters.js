import React, { useState, useEffect } from 'react';
import {Button, Checkbox, FormControlLabel, FormGroup, Select, Divider, makeStyles, FormControl, MenuItem, FormHelperText, FormLabel, RadioGroup, Radio, TextField, InputBase, Input, Typography, Slider } from '@material-ui/core';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listTags } from './actions/tagsActions';
import 'date-fns';
import Grid from '@material-ui/core/Grid';
import DateFnsUtils from '@date-io/date-fns';
import {
  MuiPickersUtilsProvider,
  KeyboardTimePicker,
  KeyboardDatePicker,
} from '@material-ui/pickers';


const useStyles = makeStyles((theme) => ({
  formControl: {
    margin: theme.spacing(1),
    marginLeft: theme.spacing(18),
    minWidth: 120,
  },
  root: {
    width: 120,
    marginLeft: theme.spacing(2),
  },
  selectEmpty: {
    marginTop: theme.spacing(2),
  },
}));

export default function OrdersFilters(props) {

  const [status,setStatus] = useState('');
  const [fromDate, setFromDate] =  React.useState(new Date('2014-08-18T21:11:54'));
  const [toDate, setToDate] =  React.useState(new Date('2021-08-18T21:11:54'));
  const orderStatuses = [{
    id: 1,
    name: "В процес на обработка",
  },
  {
    id: 2,
    name: "Изпратена",
  },
  {
    id: 3,
    name: "Получена",
  }
];
  const classes = useStyles();
  useEffect(() => {
},[]);

  const updateStatus = e => {
    setStatus(e.target.value);
    props.filterStatus(e.target.value);
  }

  const handleFromDateChange = (date) => {
    setFromDate(date);
    props.fromDateFilter(date);
  };
  const handleToDateChange = (date) => {
    setToDate(date);
    props.toDateFilter(date);
  };
  return (
<div style={{marginLeft:'90px',marginTop:'50px'}}>
<h2>Интерфейс за поръчки</h2>
<form id="filterForm">
          <Select
        value={status}
        onChange={updateStatus}
        displayEmpty
        inputProps={{ 'aria-label': 'Without label' }}
      >
        <MenuItem value="">
          <em>Филтрирайте по статус</em>
          </MenuItem>
          {orderStatuses.map(tag => (
             <MenuItem key={tag.id} value={tag.name}>{tag.name}</MenuItem>

          ))}
      </Select>
      <MuiPickersUtilsProvider utils={DateFnsUtils}>
    <Grid container justify="start">
      <KeyboardDatePicker
        style={{marginRight:"50px"}}
        margin="normal"
        id="date-picker-dialog"
        label="НАПРАВЕНА НА - ОТ"
        format="dd/MM/yyyy"
        value={fromDate}
        onChange={handleFromDateChange}
        KeyboardButtonProps={{
          'aria-label': 'change date',
        }}
      />
    <KeyboardDatePicker
        margin="normal"
        id="date-picker-dialog"
        label="НАПРАВЕНА НА - ДО"
        format="dd/MM/yyyy"
        value={toDate}
        onChange={handleToDateChange}
        KeyboardButtonProps={{
          'aria-label': 'change date',
        }}
      />
    </Grid>
  </MuiPickersUtilsProvider>

  </form>
</div>

  );
}
