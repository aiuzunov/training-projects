import React from 'react';
import clsx from 'clsx';
import { updatePermissions,listRoles } from './actions/rpActions';
import { useState, useEffect } from 'react';
import { makeStyles, useTheme } from '@material-ui/core/styles';
import Input from '@material-ui/core/Input';
import InputLabel from '@material-ui/core/InputLabel';
import MenuItem from '@material-ui/core/MenuItem';
import FormControl from '@material-ui/core/FormControl';
import ListItemText from '@material-ui/core/ListItemText';
import Select from '@material-ui/core/Select';
import { useSelector, useDispatch } from 'react-redux';
import Checkbox from '@material-ui/core/Checkbox';
import Chip from '@material-ui/core/Chip';
import { employeeSign } from './actions/employeeActions';


const useStyles = makeStyles((theme) => ({
  formControl: {
    margin: theme.spacing(1),
    minWidth: 120,
    maxWidth: 300,
  },
  chips: {
    display: 'flex',
    flexWrap: 'wrap',
  },
  chip: {
    margin: 2,
  },
  noLabel: {
    marginTop: theme.spacing(3),
  },
}));

const ITEM_HEIGHT = 48;
const ITEM_PADDING_TOP = 8;
const MenuProps = {
  PaperProps: {
    style: {
      maxHeight: ITEM_HEIGHT * 4.5 + ITEM_PADDING_TOP,
      width: 250,
    },
  },
};

function getStyles(name, personName, theme) {
  return {
    fontWeight:
      personName.indexOf(name) === -1
        ? theme.typography.fontWeightRegular
        : theme.typography.fontWeightMedium,
  };
}

export default function TestPermissions(props) {
  const classes = useStyles();
  const theme = useTheme();
  const rpList = useSelector((state) => state.rpList);
  const { rp , loading, error} = rpList;
  const [refresh,setRefresh] = useState(0);
  const updatePermission = useSelector((state) => state.updatePermission);
  const { success , loading:updateLoading, error:updateError} = updatePermission;
  const dispatch = useDispatch();


useEffect(() => {
  dispatch(listRoles());


}, [success]);
  const permHandler = (role_id,perm_id,action) => {
    if((props.perms).includes("Edit Permissions")){


    dispatch(updatePermissions(role_id,perm_id,action));
    }
}
  return (
    <div style={{marginLeft:"60px"}}>
    <h2> Интерфейс за права </h2>
      <div className="product-list">
          <table className="rtable rtable--flip">
              <thead>
                  <tr>
                      <th>
                          Роля
                      </th>
                      <th>
                          Интерфейс за продукти
                      </th>
                      <th>
                        Интерфейс за поръчки

                      </th>
                      <th>
                      Интерфейс за потребители

                      </th>
                      <th>
                      Интерфейс за служители

                      </th>
                      <th>
                          Справки
                      </th>
                      <th>
                          Интерфейс за права
                      </th>
                      <th>
                          Създаване на продукти
                      </th>
                      <th>
                          Обновяване на продукти
                      </th>
                      <th>
                          Скриване на продукти
                      </th>
                      <th>
                          Създаване на потребители
                      </th>
                      <th>
                          Редактиране на потребители
                      </th>
                      <th>
                          Създаване на поръчки
                      </th>
                      <th>
                          Редактиране на поръчки
                      </th>
                      <th>
                          Редактиране на права
                      </th>
                      <th>
                          Създаване на служители
                      </th>
                      <th>
                          Редактиране на служители
                      </th>

                  </tr>
              </thead>
              <tbody>

              {rp&&rp.map(role => (
                  <tr key={role.id}>
                  <td>
                       {role.role}
                  </td>
                  <td>
                      {role.permissions.includes("Продукти") ? <div>✓ <button   onClick={() => permHandler(role.id,1,'take')}>Промени</button></div> : <div>✗ <button   onClick={() => permHandler(role.id,1,'give')}>Промени</button></div> }
                  </td>
                  <td>
                      {role.permissions.includes("Поръчки") ?  <div>✓ <button   onClick={() => permHandler(role.id,2,'take')}>Промени</button></div> : <div>✗ <button   onClick={() => permHandler(role.id,2,'give')}>Промени</button></div>}

                  </td>
                  <td>
                      {role.permissions.includes("Потребители") ? <div>✓ <button   onClick={() => permHandler(role.id,3,'take')}>Промени</button></div> : <div>✗ <button   onClick={() => permHandler(role.id,3,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Служители") ?<div>✓ <button   onClick={() => permHandler(role.id,4,'take')}>Промени</button></div> : <div>✗ <button   onClick={() => permHandler(role.id,4,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("View Stats") ?<div>✓ <button   onClick={() => permHandler(role.id,5,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,5,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Права") ?<div>✓ <button   onClick={() => permHandler(role.id,6,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,6,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Create Products") ?<div>✓ <button   onClick={() => permHandler(role.id,7,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,7,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Edit Products") ?<div>✓ <button   onClick={() => permHandler(role.id,8,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,8,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Hide Products") ?<div>✓ <button   onClick={() => permHandler(role.id,9,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,9,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Create Users") ?<div>✓ <button   onClick={() => permHandler(role.id,10,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,10,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Edit Users") ?<div>✓ <button   onClick={() => permHandler(role.id,11,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,11,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Create Orders") ?<div>✓ <button   onClick={() => permHandler(role.id,12,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,12,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Edit Orders") ?<div>✓ <button   onClick={() => permHandler(role.id,13,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,13,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Edit Permissions") ?<div>✓ <button   onClick={() => permHandler(role.id,14,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,14,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Create Employees") ?<div>✓ <button   onClick={() => permHandler(role.id,15,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,15,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("Edit Employees") ?<div>✓ <button   onClick={() => permHandler(role.id,16,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,16,'give')}>Промени</button></div>}
                  </td>
              </tr>
              ))}



              </tbody>
          </table>
      </div>
    </div>
  );
}
