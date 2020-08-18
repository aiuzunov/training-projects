import React, { useEffect, useState } from 'react';
import NavBar from './NavBar';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import { listIncomes,listSoldProducts,listRegisteredUsers } from './actions/statsActions';


function BackOfficeStats(){
    const [count, setCount] = useState([]);
    const incomesList = useSelector((state) => state.incomesList);
    const { incomes , loading: incomesLoading, error:incomesError } = incomesList;
    const soldProductsList = useSelector((state) => state.soldProductsList);
    const { soldProducts , loading: soldProductsLoading, error:soldProductsError } = soldProductsList;
    const regUsersList = useSelector((state) => state.regUsersList);
    const { regUsers , loading: regUsersLoading, error:regUsersError } = regUsersList;
    const dispatch = useDispatch();


    useEffect(() => {
      dispatch(listIncomes());
      dispatch(listSoldProducts());
      dispatch(listRegisteredUsers());
      },[]);

    return(
      <div>
       <NavBar />
      <div className="product-list">
          <table className="table">
              <thead>
                  <tr>
                      <th>
                          Месец
                      </th>
                      <th>
                          Приходи
                      </th>


                  </tr>
              </thead>
              <tbody>
                  {incomes.map(income => (
                      <tr>
                      <td>
                          {income.month}
                      </td>
                      <td>
                           {income.sum}
                      </td>
                  </tr>
                  ))}



              </tbody>
          </table>
      </div>
      <div className="product-list">
          <table className="table">
              <thead>
                  <tr>
                      <th>
                          Месец
                      </th>
                      <th>
                          Брой продадени продукти
                      </th>


                  </tr>
              </thead>
              <tbody>
                  {soldProducts.map(sp => (
                      <tr>
                      <td>
                          {sp.month}
                      </td>
                      <td>
                           {sp.sales}
                      </td>
                  </tr>
                  ))}



              </tbody>
          </table>
      </div>
      <div className="product-list">
          <table className="table">
              <thead>
                  <tr>
                      <th>
                          Месец
                      </th>
                      <th>
                          Регистрирали се потребители
                      </th>


                  </tr>
              </thead>
              <tbody>
                  {regUsers.map(user => (
                      <tr>
                      <td>
                          {user.month}
                      </td>
                      <td>
                          {user.count}
                      </td>
                  </tr>
                  ))}



              </tbody>
          </table>
      </div>
      </div>
    );
}



export default BackOfficeStats;
