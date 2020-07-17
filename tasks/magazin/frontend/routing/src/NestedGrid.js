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
   /* const getProducts = async () => {
      try {
        if(props.search!=""){
          const response = await fetch(`http://localhost:5000/products/${renderstartid}/${props.search}`);
          const products = await response.json();
          setProducts(products);
        }
        else{
          const response = await fetch(`http://localhost:5000/products/${renderstartid}`);
          const products = await response.json();
          setProducts(products);
        }
       
      } catch (err) {
        console.log(err.message);
      }
    } */
    useEffect(() => {
      dispatch(listProducts(props.search,renderstartid));
    },[props.pageNumber,props.search]);    
    
    return ( 
      loading ? <div> loadinggggg</div> : error ? <div> errorgggg </div> :
      
       (<Grid container className={classes.productContainer} 
            spacing={0}
            direction="row"
            
            style={{ minHeight: '100vh'}}
        >
         
        {products.map(product => (
          
          getProductCard(product.id,product.name,product.image,product.price,product.description)
        ))}

      </Grid>)
      
     
      
    );
  }


export default NestedGrid;