import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Typography from '@material-ui/core/Typography';
import Pagination from '@material-ui/lab/Pagination';


const useStyles = makeStyles((theme) => ({
    root: {
      '& > * + *': {
        marginTop: theme.spacing(2),
      },
    },
  }));

const CRUDPagination = ({ postsPerPage,totalPosts, paginate}) => {
    const pageNumbers = [];
    const classes = useStyles();
    const [page, setPage] = React.useState(1);
    const handleChange = (event, value) => {
        setPage(value);
      };
    

    return (

        <div className={classes.root}>
        <Pagination style={{ backgroundColor: 'white'}}
              color="secondary" count={Math.ceil(totalPosts / postsPerPage)} page={page} onChange={handleChange}  onChangePage={paginate(page)}/>
         </div>
            
    );
}

export default CRUDPagination;