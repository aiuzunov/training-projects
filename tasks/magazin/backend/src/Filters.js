import React, { useState, useEffect } from 'react';
import { Checkbox, FormControlLabel, FormGroup, Select, Divider, makeStyles, FormControl, MenuItem, FormHelperText, FormLabel, RadioGroup, Radio, Slider, Typography, Button } from '@material-ui/core';
import BasicPagination from './BasicPagination';
import ExitToAppIcon from '@material-ui/icons/ExitToApp';
import { Link } from 'react-router-dom';
import Cookie from 'js-cookie';


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


export default function Filters(props) {
  const classes = useStyles();
  const [tagid, setTagid] = useState('');
  const [price, setPrice] = React.useState([0, 150]);
  const [finalPrice, setFinalPrice] = React.useState([0,150]);
  const handleCategoryChange = (event) => {
    setTagid(event.target.value);
  };

  const handlePriceChange = (event, newPrice) => {
    setPrice(newPrice);
  };

  const logoutHandler = () => {
    Cookie.remove("userInfo");
  }
  useEffect(() => {
   
},[tagid]);
  return (
    <div>
      <div className="filterWrapper">
       
        <div className="categoryFilter">
        <Select
      value={tagid}
      onChange={handleCategoryChange}
      displayEmpty
      inputProps={{ 'aria-label': 'Without label' }}
    >
      <MenuItem value="">
        <em>Всички</em>
        </MenuItem>
        {props.tags.map(tag => (
           <MenuItem key={tag.id} value={tag.id}>{tag.name}</MenuItem>
          
        ))}
    </Select>
    <FormHelperText>Изберете категория</FormHelperText>
        </div>
         <div className="priceFilter">
        <Typography id="range-slider" gutterBottom>
        Филтрирай по цена
      </Typography>
      <Slider
        className={classes.root}
        value={price}
        onChange={handlePriceChange}
        valueLabelDisplay="auto"
        aria-labelledby="range-slider"
      />
        </div>
   
      </div>
    

  
 

   <BasicPagination price={price} tagid={tagid} search={props.search}/>
   
      
   
    </div>

   
  );
}
