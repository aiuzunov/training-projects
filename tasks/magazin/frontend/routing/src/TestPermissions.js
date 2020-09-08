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

export default function TestPermissions() {
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
}, [refresh]);
  const permHandler = (role_id,perm_id,action) => {
    dispatch(updatePermissions(role_id,perm_id,action));
    setRefresh(!refresh);

}
  return (
    <div>

      <div className="product-list">
          <table className="table">
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

                  </tr>
              </thead>
              <tbody>

              {rp&&rp.map(role => (
                  <tr key={role.id}>
                  <td>
                       {role.role}
                  </td>
                      {role.permissions.includes("View Product Interface") ? <div>✓ <button   onClick={() => permHandler(role.id,1,'take')}>Промени</button></div> : <div>✗ <button   onClick={() => permHandler(role.id,1,'give')}>Промени</button></div> }
                  <td>
                      {role.permissions.includes("View Orders Interface") ?  <div>✓ <button   onClick={() => permHandler(role.id,2,'take')}>Промени</button></div> : <div>✗ <button   onClick={() => permHandler(role.id,2,'give')}>Промени</button></div>}

                  </td>
                  <td>
                      {role.permissions.includes("View Users Interface") ? <div>✓ <button   onClick={() => permHandler(role.id,3,'take')}>Промени</button></div> : <div>✗ <button   onClick={() => permHandler(role.id,3,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("View Employees Interface") ?<div>✓ <button   onClick={() => permHandler(role.id,4,'take')}>Промени</button></div> : <div>✗ <button   onClick={() => permHandler(role.id,4,'give')}>Промени</button></div>}
                  </td>
                  <td>
                      {role.permissions.includes("View Stats") ?<div>✓ <button   onClick={() => permHandler(role.id,5,'take')}>Промени</button></div>: <div>✗ <button   onClick={() => permHandler(role.id,5,'give')}>Промени</button></div>}
                  </td>
              </tr>
              ))}



              </tbody>
          </table>
      </div>
    </div>
  );
}
