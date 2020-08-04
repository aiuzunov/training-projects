import React from 'react';
import Pagination from '@material-ui/lab/Pagination';
import {useEffect,useState} from  'react';
import {Link} from 'react-router-dom';
import { Route } from 'react-router';
import PaginationItem from '@material-ui/lab/PaginationItem';
import NestedGrid from './NestedGrid';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';


export default function BasicPagination(props) {
  const productList = useSelector((state) => state.productList);
  const { products , loading, error } = productList;
  const [count,setCount] = useState([]);
    const getCount = async () => {
      try {
        setCount(products.length);
        }
         catch (err) {
        console.log(err.message);
      }
    }
    useEffect(() => {
      
      getCount();
    },[products.length,props.tagid,props.search]);
  var pagecount = parseInt(count / 9);
  if (count % 9 !== 0){
    pagecount = pagecount + 1;
  }
  

  return (
   
   
      <Route>
        {({ location }) => {
          const query = new URLSearchParams(location.search);
          const page = parseInt(query.get('page') || '1', 10);
          
          return (
            <div>
            <NestedGrid price={props.price} tagid ={props.tagid} search={props.search} pageNumber={page}/>
            <Pagination
              style={{ backgroundColor: 'white'}}
              color="secondary"
              page={page}
              count={pagecount}
              renderItem={(item) => (
                <PaginationItem
                  component={Link}
                  to={`/${item.page === 1 ? '' : `?page=${item.page}`}`}
                  {...item}
                />
              )}
            /></div>
          );
        }}
          
       
      </Route>
      
    

  );
}


