import React from 'react';
import PaypalExpressBtn from 'react-paypal-express-checkout';
import { saveOrder } from './actions/orderActions';
import { useDispatch } from 'react-redux';
import Cookie from 'js-cookie';
import Button from '@material-ui/core/Button';
import Snackbar from '@material-ui/core/Snackbar';
import MuiAlert from '@material-ui/lab/Alert';
import { makeStyles } from '@material-ui/core/styles';

function Alert(props) {
  return <MuiAlert elevation={6} variant="filled" {...props} />;
}

const useStyles = makeStyles((theme) => ({
  root: {
    width: '100%',
    '& > * + *': {
      marginTop: theme.spacing(2),
    },
  },
}));




function PayPal(props)
{
      const classes = useStyles();
      const [openCancel, setOpenCancel] = React.useState(false);
      const [openSuccess, setOpenSuccess] = React.useState(false);
      const [openError, setOpenError] = React.useState(false);

    const handleCloseCancel = (event, reason) => {
      if (reason === 'clickaway') {
        return;
      }

      setOpenCancel(false);
    };
    const handleCloseError = (event, reason) => {
      if (reason === 'clickaway') {
        return;
      }

      setOpenError(false);
    };

    const handleCloseSuccess = (event, reason) => {
      if (reason === 'clickaway') {
        return;
      }

      setOpenSuccess(false);
    };

        const dispatch = useDispatch();

        const onSuccess = (payment) => {
                    setOpenSuccess(true)
                    var currentdate = new Date();
                    var create_date =  currentdate.getDate() + "/"
                    + (currentdate.getMonth()+1)  + "/"
                    + currentdate.getFullYear() + " @ "
                    + currentdate.getHours() + ":"
                    + currentdate.getMinutes() + ":"
                    + currentdate.getSeconds();
                    let user_id = props.user_id;
                    let address_id = props.address_id;
                    let cart_items = props.cart_items;
                    let price = props.totalprice;
                    dispatch(saveOrder({create_date,payment,user_id,address_id,price,cart_items,currency}));
                    Cookie.remove('cartItems');
                    window.location = "/cart"

        }

        const onCancel = (data) => {
          setOpenCancel(true)

        }

        const catchError = (err) => {
          setOpenError(true)
        }

        const onError = (err) => {
          setOpenError(true)

        }


        let env = 'sandbox';
        let currency = 'EUR';
        let total = props.totalprice;

        const client = {
            sandbox:    'AXNqBHTR7vIlxxjf1WI-h51F-H6D5kFJ8qvjNui92jrhyYtL6shKv2VFtyqit7oRylrKJO1pkFHtRXcD',
            production: '',
        }
        // In order to get production's app-ID, you will have to send your app to Paypal for approval first
        // For sandbox app-ID (after logging into your developer account, please locate the "REST API apps" section, click "Create App"):
        //   => https://developer.paypal.com/docs/classic/lifecycle/sb_credentials/
        // For production app-ID:
        //   => https://developer.paypal.com/docs/classic/lifecycle/goingLive/

        // NB. You can also have many Paypal express checkout buttons on page, just pass in the correct amount and they will work!
        return (
          <div>
          <Snackbar open={openSuccess} autoHideDuration={6000} onClose={handleCloseSuccess}>
            <Alert onClose={handleCloseSuccess} severity="success">
              Плащането беше успешно, благодарим ви за поръчката!

            </Alert>
          </Snackbar>
          <Snackbar open={openCancel} autoHideDuration={6000} onClose={handleCloseCancel}>
            <Alert onClose={handleCloseCancel} severity="warning">
            Отказахте се от плащането!
            </Alert>
          </Snackbar>
          <Snackbar open={openError} autoHideDuration={6000} onClose={handleCloseError}>
            <Alert onClose={handleCloseError} severity="error">
            Възникна грешка при плащането!
            </Alert>
          </Snackbar>
            <PaypalExpressBtn env={env} shipping={2} client={client} catchError={catchError} currency={currency} total={total} onError={onError} onSuccess={onSuccess} onCancel={onCancel} style={{
                size:'large',
                color:'blue',
                shape: 'rect',
                label: 'checkout'
            }} />
            </div>
        );
}

export default PayPal;
