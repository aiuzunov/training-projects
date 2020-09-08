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

export default function EmployeesFilters(props) {
  const [username,setUsername] = useState('');
  const [email,setEmail] = useState('');
  const [role,setRole] = useState('');
  const employeeRoles = [{
    id: 1,
    name: "viewer",
    real: 1
  },
  {
    id: 2,
    name: "writer",
    real: 2

  }
];
  const classes = useStyles();
  useEffect(() => {
},[]);


const getUsername = e => {
  e.preventDefault();
  props.filterEUsername(username);
}
const getEmail = e => {
  e.preventDefault();
  props.filterEEmail(email);
}
  const updateUsername = e => {
    setUsername(e.target.value);
  }
  const updateEmail = e => {
    setEmail(e.target.value);
  }
  const updateRole = e => {
    setRole(e.target.value);
    props.filterRole(e.target.value);
  }
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
        value={role}
        onChange={updateRole}
        displayEmpty
        inputProps={{ 'aria-label': 'Without label' }}
      >
        <MenuItem value="">
          <em>Филтрирай по роля</em>
          </MenuItem>
          {employeeRoles.map(tag => (
             <MenuItem key={tag.id} value={tag.name}>{tag.name}</MenuItem>

          ))}
      </Select>
      </Grid>

</form>
</div>

  );
}
