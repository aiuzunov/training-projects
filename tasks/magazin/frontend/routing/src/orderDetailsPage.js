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
  console.log(orderItems)
  return orderloading ? <div>Loading ...</div> : ordererror ? <div>{error}</div> :
    <div>
    <NavBar/>
    <div>
      <div className="placeorder">
        <div className="placeorder-info">
          <div>
            <h3>
                Адрес на доставката
          </h3>

          <div className="product-list">

                  <table border="1" align className="table">
                      <thead>
                              <th>
                                  Адрес
                              </th>
                              <th>
                                  Град
                              </th>
                              <th>
                                  Държава
                              </th>
                              <th>
                                  Пощенски код
                              </th>

                      </thead>
                      <tbody>
                            <tr>
                              <td>
                                   {address[0]&&address[0].address}
                              </td>
                              <td>
                                   {address[0]&&address[0].city}
                              </td>
                              <td>
                                   {address[0]&&address[0].country}
                              </td>
                              <td align="right">
                                   {address[0]&&address[0].postalcode}
                              </td>
                            </tr>

                    </tbody>
                      <h3>Детайли за потребителя</h3>
                    <thead>
                      <th>
                          Потребителско име
                      </th>
                      <th>
                          Име на потребителя
                      </th>

                      <th>
                          Имейл на потребителя
                      </th>
                    </thead>
                    <tbody>
                      <tr>
                              <td>
                                   {user&&user.username}
                              </td>
                              <td>
                                   {user&&user.name}
                              </td>
                              <td>
                                   {user&&user.email}
                              </td>
                          </tr>
                    </tbody>
                    <h3>Детайли за плащането</h3>
                    <thead>
                      <th>
                          Дата на плащане
                      </th>
                      <th>
                          Лице извършило плащането
                      </th>
                      <th>
                          Имейл на плащача
                      </th>
                      <th>
                          Платена сума
                      </th>
                    </thead>
                    <tbody>
                    <tr>
                              <td>
                                   {payment[0]&&payment[0].time_of_payment}
                              </td>
                              <td>
                                   {payment[0]&&payment[0].recipient_name}
                              </td>
                              <td>
                                    {payment[0]&&payment[0].recipient_email}
                              </td>
                              <td align="right">
                                    {payment[0]&&payment[0].payment_sum} EUR
                              </td>

                    </tr>
                    </tbody>
                    <h3>Информация за поръчката</h3>
                    <thead>
                      <th>
                          Дата на създаване
                      </th>
                      <th>
                          Статус на поръчката
                      </th>
                      <th>
                          Обща сума на поръчката
                      </th>
                    </thead>
                    <tbody>
                    <tr>
                              <td>
                                   {order[0] && order[0].created}
                              </td>
                              <td>
                                   {order[0] && order[0].status}
                              </td>
                              <td align="right">
                                    {order[0] && order[0].price} EUR
                              </td>

                    </tr>
                    </tbody>
                  </table>
              </div>




          </div>
          <div className="item-list">
                <table border="1" className="table">
                    <thead>
                      <h2>
                      Продуки:
                      </h2>
                        <tr>
                          <th>
                              Изображение
                          </th>
                            <th>
                                Име
                            </th>
                            <th>
                                Цена
                            </th>
                            <th>
                                Описание
                            </th>
                            <th>
                                Брой
                            </th>

                        </tr>
                    </thead>
                    <tbody>
                        {orderItems.map(item => (
                            <tr key={item.id}>
                            <td className="image">
                                   <img  src={item.image}></img>
                            </td>
                            <td>
                                 {item.name}
                            </td>
                            <td align="right">
                                 {Number(item.price).toFixed(2)} EUR
                            </td>
                            <td>
                                 {item.description}
                            </td>
                            <td  align="right">
                                {item.quantity} брой/я
                            </td>

                        </tr>
                        ))}



                    </tbody>
                </table>
            </div>


        </div>

      </div>
    </div>
    </div>


}

export default OrderDetailsPage;
