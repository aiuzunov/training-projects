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

export default function UsersFilters(props) {
  const [username,setUsername] = useState('');
  const [email,setEmail] = useState('');
  const [verified,setVerified] = useState('');
  const [fromDate, setFromDate] =  React.useState(new Date('2014-08-18T21:11:54'));
  const [toDate, setToDate] =  React.useState(new Date('2021-08-18T21:11:54'));
  const [groupBy, setGroupBy] = useState('date');
  const userStatuses = [{
    id: 1,
    name: "Потвърдени",
    real: 'true'
  },
  {
    id: 2,
    name: "Непотвърдени",
    real: 'false'

  }
];
const groupByOptions = [{
  id: 1,
  name: "MONTH",
},
{
  id: 2,
  name: "YEAR",
},
{
  id:3,
  name: "DATE"
}
];
  const classes = useStyles();
  useEffect(() => {
},[]);


const getUsername = e => {
  e.preventDefault();
  props.filterUsername(username);
}
const getEmail = e => {
  e.preventDefault();
  props.filterEmail(email);
}
  const updateUsername = e => {
    setUsername(e.target.value);
  }
  const updateEmail = e => {
    setEmail(e.target.value);
  }
  const updateVerified = e => {
    setVerified(e.target.value);
    props.filterVerified(e.target.value);
  }
  const updateGroupBy = e => {
    setGroupBy(e.target.value);
  }

  const handleFromDateChange = (date) => {
    setFromDate(date);
    props.filterFromDate(date)
  };
  const handleToDateChange = (date) => {
    setToDate(date);
    props.filterToDate(date);
  };
  return (
<div style={{marginLeft:'150px',marginTop:'50px'}}>
<form id="filterForm">
<Grid container spacing={4} justify="start" direction = "rows">
<Grid container item xs={12} spacing={1}>
  <form onSubmit={getUsername}>
          <TextField
            value={username}
            onChange={updateUsername}
            placeholder="Потребителско име…"
            classes={{
              root: classes.inputRoot,
              input: classes.inputInput,
            }}
            inputProps={{ 'aria-label': 'search' }}
          />
  </form>
  </Grid>

  <form onSubmit={getEmail}>
          <TextField
            style={{marginRight:'10px',marginLeft:'10px'}}
            value={email}
            onChange={updateEmail}
            placeholder="Имейл…"
            classes={{
              root: classes.inputRoot,
              input: classes.inputInput,
            }}
            inputProps={{ 'aria-label': 'search' }}
          />
  </form>
          <Select
        value={verified}
        onChange={updateVerified}
        displayEmpty
        inputProps={{ 'aria-label': 'Without label' }}
      >
        <MenuItem value="">
          <em>Потвърдени/Непотвърдени</em>
          </MenuItem>
          {userStatuses.map(tag => (
             <MenuItem key={tag.id} value={tag.real}>{tag.name}</MenuItem>

          ))}
      </Select>
      <Grid container item xs={12} spacing={3}>

      <MuiPickersUtilsProvider utils={DateFnsUtils}>
    <Grid container justify="start">
      <KeyboardDatePicker
        style={{marginRight:"50px"}}
        margin="normal"
        id="date-picker-dialog"
        label="ДАТА НА РЕГИСТРАЦИЯ - ОТ"
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
        label="ДАТА НА РЕГИСТРАЦИЯ - ДО"
        format="dd/MM/yyyy"
        value={toDate}
        onChange={handleToDateChange}
        KeyboardButtonProps={{
          'aria-label': 'change date',
        }}
      />
    </Grid>
  </MuiPickersUtilsProvider>
  </Grid>

  </Grid>

  </form>
</div>

  );
}
