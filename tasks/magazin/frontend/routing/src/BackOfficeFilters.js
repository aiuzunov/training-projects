import React, { useState, useEffect } from 'react';
import { Checkbox, FormControlLabel, FormGroup, Select, Divider, makeStyles, FormControl, MenuItem, FormHelperText, FormLabel, RadioGroup, Radio, TextField, InputBase, Input } from '@material-ui/core';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listTags } from './actions/tagsActions';


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
  
export default function BackOfficeFilters(props) {
  const classes = useStyles();
  const [search, setSearch] = useState("");
  const [finishedSearch, setFinishedSearch] = useState("");
  const [tagid, setTagid] = useState('');
  const [price,setPrice] = useState(''); 
  const productList = useSelector((state) => state.productList);
  const { products , loading, error } = productList;
  const tagsList = useSelector((state) => state.tagsList);
  const { tags , loading: tagsLoading, error:tagsError } = tagsList;
  const dispatch = useDispatch();
  
  const updateSearch = e => {
    setSearch(e.target.value);
  }

  const getSearch = e => {
    console.log(1)
    e.preventDefault();
    setFinishedSearch(search);
  }


  const handleCategoryChange = (event) => {
    setTagid(event.target.value);
  };

  const handlePriceChange = (event) => {
    setPrice(event.target.value);
  };

  useEffect(() => {
   dispatch(listProducts(price,tagid,finishedSearch));
   dispatch(listTags());
},[tagid,price,finishedSearch,props.deleted,props.saved]);

  return (
   
    <div>
    
    <FormControl className={classes.formControl}>
    <form onSubmit={getSearch}>
            <InputBase
              value={search}
              onChange={updateSearch}
              placeholder="Търсене на продукт…"
              classes={{
                root: classes.inputRoot,
                input: classes.inputInput,
              }}
              inputProps={{ 'aria-label': 'search' }}
            />
    </form>
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
        {tags.map(tag => (
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
  
    </div>

   
  );
}
