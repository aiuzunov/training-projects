import React, { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { Link } from 'react-router-dom';
import { listOrderItems, getSingleOrder } from './actions/orderActions';
import { listAddress } from './actions/addressActions';
import { getPayment } from './actions/paymentActions';
import {getUser} from './actions/userActions';
import NavBar from './NavBar';
function OrderDetailsPage(props) {
  const orderItemsList = useSelector(state => state.orderItemsList);
  const { loading, orderItems, error } = orderItemsList;
  const addressList = useSelector(state => state.addressList);
  const { loading:addresLoading, address, error:addressError } = addressList;
  const singlePaymentList = useSelector(state => state.singlePaymentList);
  const { loading:paymentLoading, payment, error:paymentError } = singlePaymentList;
  const getOrder = useSelector(state => state.getOrder);
  const { loading:orderloading, order, error:ordererror } = getOrder;
  const userGetInfo = useSelector(state => state.userGetInfo);
  const {user} = userGetInfo;
  const dispatch = useDispatch();

  useEffect(() => {
    console.log(1)
    dispatch(getSingleOrder(props.match.params.id));
    dispatch(listOrderItems(props.match.params.id));
    dispatch(listAddress(props.match.params.id));
    dispatch(getPayment(props.match.params.id));
    dispatch(getUser(props.match.params.id));

  }, []);
  console.log(address)
  return orderloading ? <div>Loading ...</div> : ordererror ? <div>{error}</div> :
    <div>
    <NavBar/>
    <div>
      <div className="placeorder">
        <div className="placeorder-info">
          <div>
            <h2>
                Адрес на доставката
          </h2>

          <h4>
              Адрес:
          </h4>
          <div>{address[0]&&address[0].address}</div>

          <h4>
              Град
          </h4>
          <div>{address[0]&&address[0].city}</div>

          <h4>
              Държава
          </h4>
          <div>{address[0]&&address[0].country}</div>

          <h4>
              Пощенски код
          </h4>
          <div>{address[0]&&address[0].postalcode}</div>


         <div>{payment[0]&&payment[0].paymentid}</div>


          </div>
          <div>
            <h2>Детайли за потребителя</h2>
            <h4>Име на потребителя</h4>
             <div>{user&&user.name}</div>
            <h4>Потребителско име</h4>
            <div>{user&&user.username}</div>
            <h4>Имейл на потребителя</h4>
            <div>{user&&user.email}</div>
          </div>
          <div>
            <h2>Детайли за плащането</h2>
            <h4>
              Лице извършило плащането:
          </h4>
          <div>{payment[0]&&payment[0].recipient_name}</div>
          <h4>
              Имейл на плащача:
          </h4>
          <div>{payment[0]&&payment[0].recipient_email}</div>
          <h4>
              Дата на плащането:
          </h4>
          <div>{payment[0]&&payment[0].time_of_payment}</div>
          <h4>
              Сума на плащането:
          </h4>
          <div>{payment[0]&&payment[0].payment_sum}</div>
          </div>
          <div>
            <ul className="cart-list-container">
              <li>
                <h2>
                Продуки:
                </h2>
                <div>
                  Цена
          </div>
              </li>
              {orderItems.map(item =>
                    <li key={item.id}>
                      <div className="cart-image">
                        <img src={`/${item.name}.png`} alt="product" />
                      </div>
                      <div className="cart-name">
                        <div>
                          <Link to={"/product/" + item.product_id}>
                            {item.name}
                          </Link>

                        </div>
                        <div>
                          Количество: {item.quantity} бр.
                        </div>
                      </div>
                      <div className="">
                        {item.price} {item.currency_id}
                      </div>
                    </li>
                  )
              }
            </ul>
          </div>


        </div>
        <div className="placeorder-action">
              <h3>Информация за поръчката</h3>
              <div><h3>Статус на поръчката</h3></div>
              <div>{order[0] && order[0].order_status}</div>
              <div><h3>Дата на създаване</h3></div>
              <div>{order[0] && order[0].created}</div>
              <div><h3>Обща сума на поръчката</h3></div>
              <div>{order[0] && order[0].price} {order[0] && order[0].currency}</div>



        </div>

      </div>
    </div>
    </div>


}

export default OrderDetailsPage;
