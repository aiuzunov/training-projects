import React, { useState, useEffect } from 'react';
import { Checkbox, FormControlLabel, FormGroup, Select, Divider, makeStyles, FormControl, MenuItem, FormHelperText } from '@material-ui/core';
import BasicPagination from './BasicPagination';

const useStyles = makeStyles((theme) => ({
    formControl: {
      margin: theme.spacing(1),
      minWidth: 120,
    },
    selectEmpty: {
      marginTop: theme.spacing(2),
    },
  }));
  
export default function Filters(props) {
  const classes = useStyles();
  const [tagid, setTagid] = useState('');

  const handleChange = (event) => {
    setTagid(event.target.value);
  };

  useEffect(() => {

},[tagid]);

  return (
    <div>
    <FormControl className={classes.formControl}>
    <Select
      value={tagid}
      onChange={handleChange}
      displayEmpty
      className={classes.selectEmpty}
      inputProps={{ 'aria-label': 'Without label' }}
    >
      <MenuItem value="">
        <em>None</em>
        </MenuItem>
        {props.tags.map(tag => (
           <MenuItem key={tag.id} value={tag.id}>{tag.name}</MenuItem>
          
        ))}
    </Select>
    <FormHelperText>Select Category</FormHelperText>
  </FormControl>
   <BasicPagination tagid={tagid} search={props.search}/>
    </div>
   
  );
}
