import React from 'react';
import PaypalExpressBtn from 'react-paypal-express-checkout';
import { saveOrder } from './actions/orderActions';
import { useDispatch } from 'react-redux';
import Cookie from 'js-cookie';


 
function PayPal(props)
{
        const dispatch = useDispatch();

        const onSuccess = (payment) => {
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
                    console.log("The payment was succeeded!", payment);
                    dispatch(saveOrder({create_date,payment,user_id,address_id,price,cart_items,currency}));
                    Cookie.remove('cartItems');
                    window.location = "/cart"

        }
 
        const onCancel = (data) => {
            console.log('The payment was cancelled!', data);
        }
 
        const onError = (err) => {
            console.log("Error!", err);
        }
 
        let env = 'sandbox'; 
        let currency = 'EUR'; 
        let total = props.totalprice; 
 
        const client = {
            sandbox:    'AXNqBHTR7vIlxxjf1WI-h51F-H6D5kFJ8qvjNui92jrhyYtL6shKv2VFtyqit7oRylrKJO1pkFHtRXcD',
            production: 'YOUR-PRODUCTION-APP-ID',
        }
        // In order to get production's app-ID, you will have to send your app to Paypal for approval first
        // For sandbox app-ID (after logging into your developer account, please locate the "REST API apps" section, click "Create App"):
        //   => https://developer.paypal.com/docs/classic/lifecycle/sb_credentials/
        // For production app-ID:
        //   => https://developer.paypal.com/docs/classic/lifecycle/goingLive/
 
        // NB. You can also have many Paypal express checkout buttons on page, just pass in the correct amount and they will work!
        return (
            <PaypalExpressBtn env={env} shipping={2} client={client} currency={currency} total={total} onError={onError} onSuccess={onSuccess} onCancel={onCancel} style={{ 
                size:'large',
                color:'blue',
                shape: 'rect',
                label: 'checkout'
            }} />
        );
}

export default PayPal;