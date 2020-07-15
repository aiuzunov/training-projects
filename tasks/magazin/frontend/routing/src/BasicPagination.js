import React from 'react';
import Pagination from '@material-ui/lab/Pagination';
import {useEffect,useState} from  'react';
import {Link} from 'react-router-dom';
import { Route } from 'react-router';
import PaginationItem from '@material-ui/lab/PaginationItem';
import NestedGrid from './NestedGrid';


export default function BasicPagination(props) {
  const [count,setCount] = useState([]);
    const getCount = async () => {
      try {
        const response = await fetch("http://localhost:5000/products/");
        const count = await response.json();
        setCount(count);
      } catch (err) {
        console.log(err.message);
      }
    }
    useEffect(() => {
      getCount();
    },[]);
  var pagecount = parseInt(count.count / 9);
  if (count.count % 9 !== 0){
    pagecount = pagecount + 1;
  }

  
  return (
   
   
      <Route>
        {({ location }) => {
          const query = new URLSearchParams(location.search);
          const page = parseInt(query.get('page') || '1', 10);
          
          return (
            <div>
            <NestedGrid search={props.search} pageNumber={page}/>
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


