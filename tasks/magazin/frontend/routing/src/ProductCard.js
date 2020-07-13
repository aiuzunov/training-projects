import React from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Card from '@material-ui/core/Card';
import CardActions from '@material-ui/core/CardActions';
import CardContent from '@material-ui/core/CardContent';
import CardMedia from '@material-ui/core/CardMedia';
import Button from '@material-ui/core/Button';
import Typography from '@material-ui/core/Typography';
import AddShoppingCartIcon from '@material-ui/icons/AddShoppingCart';

const useStyles = makeStyles({
    root: {
      backgroundColor:'#005f63',
      minWidth: 50,
      marginRight:'50px',
      marginLeft:'50px',
      marginBottom:'75px',
    },
    bullet: {
      display: 'inline-block',
      margin: '0 2px',
      transform: 'scale(0.8)',
    },
    title: {
      fontSize: 14,
    },
    colortext:{
      color:'#fff'
    },
  });


function ProductCard(props) {
    const classes = useStyles();
    const bull = <span className={classes.bullet}>•</span>;

    return(
        <Card className={classes.root} variant="outlined">
      <CardMedia 
        class={classes.media}
        image={props.image}
        style={{ width:"100%",maxWidth:"100%",height:"250px", maxHeight:"20%"}}
      />
      <CardContent>
        <Typography className={classes.colortext}  variant="h5" component="h2">
          {props.name}
        </Typography>
        <Typography className={classes.pos,classes.colortext}>
         Цена: {props.price} лв.
        </Typography>
        <Typography className={classes.colortext} variant="body2" component="p">
         {props.description}
        </Typography>
      </CardContent>
      <CardActions style={{justifyContent: 'center'}}>
        <Button className={classes.colortext}  size="medium">Learn More</Button>
        <Button className={classes.colortext} size="medium">  <AddShoppingCartIcon/>  </Button>
      </CardActions>
    </Card>
    );
}

export default ProductCard;