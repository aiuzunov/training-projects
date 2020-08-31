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
import Autocomplete from '@material-ui/lab/Autocomplete';
import CheckBoxOutlineBlankIcon from '@material-ui/icons/CheckBoxOutlineBlank';
import CheckBoxIcon from '@material-ui/icons/CheckBox';

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

export default function ProductsFilters(props) {
  const [name,setName] = useState('');
  const [count_in_stock,setQuantity] = useState('');
  const [tagid,setTagId] = useState([]);
  const [age,setAge] = useState('');
  const [price, setPrice] = React.useState([0, 100]);
  const [fromDate, setFromDate] =  React.useState(new Date('2014-08-18T21:11:54'));
  const [toDate, setToDate] =  React.useState(new Date('2021-08-18T21:11:54'));
  const [groupBy, setGroupBy] = useState('date');
  const tagsList = useSelector((state) => state.tagsList);
  const { tags , loading: tagsLoading, error:tagsError } = tagsList;
  const dispatch = useDispatch();
  const userStatuses = [{
    id: 1,
    name: "В наличност",
    real: 3
  },
  {
    id: 2,
    name: "Почти изчерпани",
    real: 2

  },
  {
    id: 3,
    name: "Изчерпани",
    real: 1
  }
];
const sortByCreation = [{
  id: 1,
  name: "Стари",
  real: "ASC"
},
{
  id: 2,
  name: "Нови",
  real: "DESC"
}
];


  const classes = useStyles();
  useEffect(() => {
    dispatch(listTags());
    console.log(tagid)
},[tagid]);

  const updateSearchFilter = e => {
    setName(e.target.value);
  }

 const getSearch = e => {
   e.preventDefault();
   props.filterName(name);

 }

  const updateQuantity = e => {
    setQuantity(e.target.value);
    props.filterCIS(e.target.value);
  }
  const updateAge = e => {
    setAge(e.target.value);
    props.filterAge(e.target.value);
  }
  const updateGroupBy = e => {
    setGroupBy(e.target.value);
  }
  const updateTagId = e => {
    setTagId(e.target.value);
    props.filterTag(e.target.value);
  }

  const handlePriceChange = (event, newPrice) => {
    setPrice(newPrice);
    props.filterPrice(newPrice);
  };


  const handleFromDateChange = (date) => {
    setFromDate(date);
    props.filterFromDate(date);
  };
  const handleToDateChange = (date) => {
    setToDate(date);
    props.filterToDate(date);
  };


  const icon = <CheckBoxOutlineBlankIcon fontSize="small" />;
  const checkedIcon = <CheckBoxIcon fontSize="small" />;
  return (
<div style={{marginLeft:'150px',marginTop:'50px'}}>
<form id="filterForm">
<Grid container spacing={4} justify="start" direction = "rows">
<Grid container item xs={12} spacing={1}>
          <form onSubmit={getSearch}>
          <TextField
            value={name}
            onChange={updateSearchFilter}
            placeholder="Име на продукта…"
            classes={{
              root: classes.inputRoot,
              input: classes.inputInput,
            }}
            inputProps={{ 'aria-label': 'search' }}
          />
      </form>
          </Grid>

          <Select
        style={{minWidth:"250px",marginTop:"10px",marginLeft:"7px",marginRight:"70px"}}
        value={count_in_stock}
        onChange={updateQuantity}
        displayEmpty
        inputProps={{ 'aria-label': 'Without label' }}
      >

        <MenuItem value="">
          <em>Филтрирай по количество</em>
          </MenuItem>
          {userStatuses.map(tag => (
             <MenuItem key={tag.id} value={tag.real}>{tag.name}</MenuItem>

          ))}
      </Select>

          <Select
        style={{minWidth:"250px"}}
        value={age}
        onChange={updateAge}
        displayEmpty
        inputProps={{ 'aria-label': 'Without label' }}
      >
        <MenuItem value="">
          <em>Най-нови / Най-стари</em>
          </MenuItem>
          {sortByCreation.map(tag => (
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
        label="ДАТА НА СЪЗДАВАНЕ - ОТ"
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
        label="ДАТА НА СЪЗДАВАНЕ - ДО"
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
  <Grid container item xs={12} spacing={3}>
  <Select
style={{minWidth:"250px"}}
value={tagid}
multiple
onChange={updateTagId}
displayEmpty
inputProps={{ 'aria-label': 'Without label' }}
>
  {tags.map(tag => (
     <MenuItem key={tag.id} value={tag.id}>{tag.name}</MenuItem>

  ))}
</Select>
<Slider
      className={classes.root}
      value={price}
      onChange={handlePriceChange}
      valueLabelDisplay="auto"
      aria-labelledby="range-slider"
    />
</Grid>
  </Grid>

  </form>
</div>

  );
}
