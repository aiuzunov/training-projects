import React, { useEffect, useState } from 'react';
import { Link } from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listOrders } from './actions/orderActions';
import NavBar from './NavBar';

function ProfileOrderList(props) {
  const ordersList = useSelector(state => state.ordersList);
  const { loading, orders, error } = ordersList;
  const userSignIn = useSelector(state=>state.userSignIn);
  const {userInfo} = userSignIn;
  const dispatch = useDispatch();
  

  useEffect(() => {
    dispatch(listOrders(userInfo.id));
    return () => {
    };
  }, []);

  return loading ? <div>Loading...</div> :
    <div>
        <NavBar/>
    <div className="content content-margined">

      <div className="order-header">
        <h3>Поръчки</h3>
      </div>
      <div className="order-list">

        <table className="table">
          <thead>
            <tr>
              <th>Направена на</th>
              <th>Обща сума на поръчката</th>
              <th>Име на потребителя</th>
              <th>Статус на поръчката</th>
            </tr>
          </thead>
          <tbody>
            {orders.map(order => (<tr key={order._id}>
              <td>{order.created}</td>
              <td>{order.price} {order.currency}</td>
              <td>{userInfo.name}</td>
              <td>{order.order_status}</td>
            
              <td>
                <Link to={"/order/" + order.id} ><button>Детайли за поръчката</button></Link>
                {' '}
              </td>
            </tr>))}
          </tbody>
        </table>

      </div>
    </div>
    </div>

}
export default ProfileOrderList;