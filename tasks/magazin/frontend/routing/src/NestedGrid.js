import React from 'react';
import './App.css';
import { makeStyles } from '@material-ui/core/styles';
import Grid from '@material-ui/core/Grid';
import ProductCard from './ProductCard';
import {useEffect,useState} from  'react';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';



const useStyles = makeStyles({
  productContainer: {
    paddingTop: '50px',
    paddingLeft:'100px',
    paddingRight:'100px',
  },
});

const getProductCard = (productid,productname,productimage,productprice,productdescription) => {
  return(
    <Grid key={productid} item xs={10} sm={4} >
      <ProductCard id={productid} name={productname} image={productimage} price={productprice} description={productdescription}/>
    </Grid>
  )
};

function NestedGrid(props){
    const classes = useStyles();
    //const [products,setProducts] = useState([]);
    const productList = useSelector((state) => state.productList);
    const { products , loading, error } = productList;
    const dispatch = useDispatch();
    var renderstartid = 9*(props.pageNumber-1);
    useEffect(() => {
      dispatch(listProducts());
    },[props.pageNumber,props.search]);    
    
    const indexOfLastProduct = props.pageNumber * 9;
    const indexOfFirstProduct = indexOfLastProduct - 9;
    const currentProducts = products.slice(indexOfFirstProduct,indexOfLastProduct);
    console.log(indexOfLastProduct,indexOfFirstProduct)
    console.log(currentProducts)
    console.log(1)

    return ( 
      loading ? <div> loadinggggg</div> : error ? <div> errorgggg </div> :
      
       (<Grid container className={classes.productContainer} 
            spacing={0}
            direction="row"
            
            style={{ minHeight: '100vh'}}
        >
         
        {currentProducts.map(product => (
          
          getProductCard(product.id,product.name,product.image,product.price,product.description)
        ))}

      </Grid>)
      
     
      
    );
  }


export default NestedGrid;