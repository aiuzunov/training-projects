import React from 'react';
import './App.css';
import { makeStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';
import ProductCard from './ProductCard';
import {useEffect,useState} from  'react';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { CircularProgress } from '@material-ui/core';
import { listPT } from './actions/ptActions';




const useStyles = makeStyles({
  productContainer: {
    paddingTop: '50px',
    paddingLeft:'100px',
    paddingRight:'100px',
  },
});

const getProductCard = (pricefilter,tagfilter,searchfilter,pageNumber,products_2,productid,productname,productimage,productprice,productcis,productdescription,productcurrency) => {
  return(
    <Grid key={productid} item xs={10} sm={4} >
      <ProductCard pricefilter={pricefilter} tagfilter={tagfilter} searchfilter={searchfilter} pageNumber={pageNumber} products = {products_2} cis ={productcis} id={productid} name={productname} image={productimage} price={productprice} description={productdescription} currency_id={productcurrency}/>
    </Grid>
  )
};

function NestedGrid(props){
    const classes = useStyles();
    const productList = useSelector((state) => state.productList);
    const { products , loading, error } = productList;
    const dispatch = useDispatch();
    useEffect(() => {
      var searchfilter = props.search;
      var pricefilter = props.price;
      var currentPage = props.pageNumber;
      var tagfilter = props.tagid;
      dispatch(listProducts({searchfilter,pricefilter,currentPage,tagfilter}));
      console.log(products)
    },[props.pageNumber,props.search,props.tagid,props.price]);
    console.log(products)
    return (
      loading ?<div>  <CircularProgress color="secondary" /></div>  :

       (<Grid container className={classes.productContainer}
            spacing={0}
            direction="row"

            style={{ minHeight: '100vh'}}
        >

        {products.map(product => (
          getProductCard(props.price,props.tagid,props.search,props.pageNumber,products,product.id,product.name,product.image,product.price,product.count_in_stock,product.description,product.currency_id)

        ))}

      </Grid>)



    );
  }


export default NestedGrid;
