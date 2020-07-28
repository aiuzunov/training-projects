import React, { useState, useEffect } from 'react';
import { Checkbox, FormControlLabel, FormGroup, Select, Divider, makeStyles, FormControl, MenuItem, FormHelperText, FormLabel, RadioGroup, Radio, TextField, InputBase, Input, Typography, Slider } from '@material-ui/core';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listTags } from './actions/tagsActions';


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
  
export default function BackOfficeFilters(props) {
  const classes = useStyles();
  const [search, setSearch] = useState("");
  const [finishedSearch, setFinishedSearch] = useState("");
  const [tagid, setTagid] = useState('');
  const [price, setPrice] = React.useState([0, 100]);
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

  const handlePriceChange = (event, newPrice) => {
    setPrice(newPrice);
  };

  useEffect(() => {
   dispatch(listProducts(price,tagid,finishedSearch));
   dispatch(listTags());
},[tagid,price,finishedSearch,props.deleted,props.saved]);

  return (
   
    <div>
    
   
  
  <div className="filterWrapper">
  <div>
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
  </div>
  
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
       {tags.map(tag => (
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
  
    </div>

   
  );
}
