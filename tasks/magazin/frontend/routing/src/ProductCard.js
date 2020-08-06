import React from "react";
import { makeStyles } from "@material-ui/core/styles";
import Card from "@material-ui/core/Card";
import CardActions from "@material-ui/core/CardActions";
import CardContent from "@material-ui/core/CardContent";
import CardMedia from "@material-ui/core/CardMedia";
import Button from "@material-ui/core/Button";
import Typography from "@material-ui/core/Typography";
import AddShoppingCartIcon from "@material-ui/icons/AddShoppingCart";
import { Link, NavLink, Route } from "react-router-dom";
import { withRouter } from "react-router-dom";
import { useSelector, useDispatch } from "react-redux";
import { useState, useEffect } from "react";
import { listPT } from "./actions/ptActions";
import {
  addToCart,
  removeFromCart,
  saveCartItem,
  deleteCartItem,
} from "./actions/cartActions";

const useStyles = makeStyles({
  root: {
    backgroundColor: "#005f63",
    minWidth: 50,
    marginRight: "50px",
    marginLeft: "50px",
    marginBottom: "75px",
  },
  bullet: {
    display: "inline-block",
    margin: "0 2px",
    transform: "scale(0.8)",
  },
  title: {
    fontSize: 14,
  },
  colortext: {
    color: "#fff",
  },
});

function ProductCard(props) {
  const dispatch = useDispatch();
  const classes = useStyles();
  const ptList = useSelector((state) => state.ptList);
  const { pts, loading: loadingPts, error: ptsError } = ptList;
  const userSignIn = useSelector((state) => state.userSignIn);
  const { userInfo } = userSignIn;
  const bull = <span className={classes.bullet}>•</span>;
  const AddToCart = () => {
    let product_id = props.id;
    let user_id = userInfo.id;
    let quantity = 1;
    dispatch(addToCart(product_id, quantity));
    dispatch(saveCartItem({ product_id, quantity, user_id }));
  };

  useEffect(() => {
    dispatch(listPT(props.pageNumber));
  }, [props.pageNumber]);
  return (
    <Card className={classes.root} variant="outlined">
      <CardMedia
        className={classes.media}
        image={`http://localhost:5000/${props.name}.png`}
        style={{
          width: "100%",
          maxWidth: "100%",
          height: "250px",
          maxHeight: "20%",
        }}
      />
      <CardContent>
        <Typography className={classes.colortext} variant="h5" component="h2">
          {props.name}
        </Typography>
        <Typography className={classes.colortext}>
          Цена: {Number(props.price).toFixed(2)} {props.currency_id}
        </Typography>
        <Typography
          className={classes.colortext}
          variant="body2"
          component="h3"
        >
          {props.cis ? <p>В наличност</p> : <p>Не е в наличност</p>}
        </Typography>
        <Typography
          className={classes.colortext}
          variant="body2"
          component="h3"
        >
          <div>Жанрове:</div>
          {pts.map((pt) =>
            pt.product_id == props.id ? <div>{pt.name} </div> : <div></div>
          )}
        </Typography>
      </CardContent>
      <CardActions style={{ justifyContent: "center" }}>
        <Link style={{ textDecoration: "none" }} to={`/product/${props.id}`}>
          <Button className={classes.colortext} size="medium">
            Научи повече
          </Button>
        </Link>

        {props.cis ? (
          <Button
            onClick={AddToCart}
            className={classes.colortext}
            size="medium"
          >
            {" "}
            <AddShoppingCartIcon />{" "}
          </Button>
        ) : (
          <div></div>
        )}
      </CardActions>
    </Card>
  );
}

export default withRouter(ProductCard);

