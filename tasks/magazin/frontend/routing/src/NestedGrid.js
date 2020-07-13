import React from 'react';
import './App.css';
import { makeStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';
import ProductCard from './ProductCard';
import {useEffect,useState} from  'react';


const useStyles = makeStyles({
  productContainer: {
    paddingTop: '50px',
    paddingLeft:'100px',
    paddingRight:'100px',
  },
});

const getProductCard = (productname,productimage,productprice,productdescription) => {
  return(
    <Grid  item xs={10} sm={4} >
      <ProductCard name={productname} image={productimage} price={productprice} description={productdescription}/>
    </Grid>
  )
};

function NestedGrid(props){
    const classes = useStyles();
    console.log(props.pageNumber);
    const [products,setProducts] = useState([]);
    var renderstartid = 9*(props.pageNumber-1);
    const getProducts = async () => {
      try {
        const response = await fetch(`http://localhost:5000/products/${renderstartid}`);
        const products = await response.json();
        setProducts(products);
      } catch (err) {
        console.log(err.message);
      }
    }
    useEffect(() => {
      getProducts();
    },[props.pageNumber]);    
    return (
      <Grid container className={classes.productContainer} 
            spacing={0}
            direction="rows"
            
            style={{ minHeight: '100vh'}}
        >
        {products.map(product => (
          getProductCard(product.name,product.image,product.price,product.description)
        ))}

      </Grid>
    );
  }


export default NestedGrid;