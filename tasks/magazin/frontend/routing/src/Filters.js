import React, { useState, useEffect } from 'react';
import { Checkbox, FormControlLabel, FormGroup, Select, Divider, makeStyles, FormControl, MenuItem, FormHelperText, FormLabel, RadioGroup, Radio } from '@material-ui/core';
import BasicPagination from './BasicPagination';

const useStyles = makeStyles((theme) => ({
    formControl: {
      margin: theme.spacing(1),
      marginLeft: theme.spacing(18),
      minWidth: 120,
    },
    selectEmpty: {
      marginTop: theme.spacing(2),
    },
  }));
  
export default function Filters(props) {
  const classes = useStyles();
  const [tagid, setTagid] = useState('');
  const [price,setPrice] = useState('');

  const handleCategoryChange = (event) => {
    setTagid(event.target.value);
  };

  const handlePriceChange = (event) => {
    setPrice(event.target.value);
  };

  useEffect(() => {

},[tagid,price]);

  return (
    <div>
    <FormControl className={classes.formControl}>
    <Select
      value={tagid}
      onChange={handleCategoryChange}
      displayEmpty
      className={classes.selectEmpty}
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
  </FormControl>
  
  <FormControl component="fieldset">
      <RadioGroup className="price-filters" row aria-label="gender" name="gender1" value={price} onChange={handlePriceChange} >
        <FormControlLabel value="0" control={<Radio />} label="Всички." />
        <FormControlLabel value="1" control={<Radio />} label="0-99 лв." />
        <FormControlLabel value="2" control={<Radio />} label="100-199 лв." />
        <FormControlLabel value="3" control={<Radio />} label="200-299 лв." />
        <FormControlLabel value="4" control={<Radio />} label=">300 лв." />
      </RadioGroup>
    </FormControl>
    
   <BasicPagination price={price} tagid={tagid} search={props.search}/>
    </div>

   
  );
}
