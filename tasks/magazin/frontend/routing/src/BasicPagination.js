import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Pagination from '@material-ui/lab/Pagination';
import {useEffect,useState} from  'react';
import {Link} from 'react-router-dom';
import Typography from '@material-ui/core/Typography';
import { MemoryRouter, Route } from 'react-router';
import PaginationItem from '@material-ui/lab/PaginationItem';
import NestedGrid from './NestedGrid';



const useStyles = makeStyles((theme) => ({
  root: {
    '& > *': {
      marginTop: theme.spacing(2),
      backgroundColor: 'white',
    },
  },
}));


export default function BasicPagination() {
  const classes = useStyles();
  const [count,setCount] = useState([]);
  const [page, setPage] = React.useState(1);
  const handleChange = (event, value) => {
    setPage(value);
  };
    const getCount = async () => {
      try {
        const response = await fetch("http://localhost:5000/products/");
        const count = await response.json();
        setCount(count);
      } catch (err) {
        console.log(err.message);
      }
    }
    console.log(count)
    useEffect(() => {
      getCount();
    },[]);
  var pagecount = parseInt(count.count / 9);
  if (count.count % 9 != 0){
    pagecount = pagecount + 1;
  }

  
  return (
   
   
      <Route>
        {({ location }) => {
          const query = new URLSearchParams(location.search);
          const page = parseInt(query.get('page') || '1', 10);
          
          return (
            <div>
            <NestedGrid pageNumber={page}/>
            <Pagination
              style={{ backgroundColor: 'white'}}
              color="secondary"
              onChange={handleChange}
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


