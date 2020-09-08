import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import axios from 'axios';
import ExitToAppIcon from '@material-ui/icons/ExitToApp';
import Cookie from 'js-cookie';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct, saveProduct, listProducts, deleteProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { employeesSignUp } from './actions/employeeActions';
import { signin, listUsers, signup } from './actions/userActions';
import { ThemeProvider } from '@material-ui/styles';
import Pagination from '@material-ui/lab/Pagination';
import CRUDPagination from './CRUDPagination';
import NavBar from './NavBar';
import AddBoxIcon from '@material-ui/icons/AddBox';
import { Button, Icon, createMuiTheme,MenuItem,Select } from '@material-ui/core';
import CancelIcon from '@material-ui/icons/Cancel';
import EditIcon from '@material-ui/icons/Edit';
import DeleteForeverIcon from '@material-ui/icons/DeleteForever';
import { listTags } from './actions/tagsActions';
import ProductsFilters from './ProductsFilters';
import UsersFilters from './UsersFilters';
import OrdersFilters from './OrdersFilters';
import Can from './Can';
import EmployeesFilters from './employeesFilters';
import { listPT } from './actions/ptActions';
import BackOfficeStats from './BackOfficeStats';
import StoreIcon from '@material-ui/icons/Store';
import { listOrders } from './actions/orderActions';
import { updateRole,listEmployees} from './actions/employeeActions';
import { updateStatus} from './actions/orderActions';
import clsx from 'clsx';
import { makeStyles, useTheme } from '@material-ui/core/styles';
import Drawer from '@material-ui/core/Drawer';
import CssBaseline from '@material-ui/core/CssBaseline';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import List from '@material-ui/core/List';
import Typography from '@material-ui/core/Typography';
import Divider from '@material-ui/core/Divider';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from '@material-ui/icons/Menu';
import ChevronLeftIcon from '@material-ui/icons/ChevronLeft';
import ChevronRightIcon from '@material-ui/icons/ChevronRight';
import ListItem from '@material-ui/core/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText';
import InboxIcon from '@material-ui/icons/MoveToInbox';
import MailIcon from '@material-ui/icons/Mail';
import MenuBookIcon from '@material-ui/icons/MenuBook';
import PersonIcon from '@material-ui/icons/Person';
import PersonAddIcon from '@material-ui/icons/PersonAdd';
import LocalMallIcon from '@material-ui/icons/LocalMall';
import NoteAddIcon from '@material-ui/icons/NoteAdd';
import ClickAwayListener from '@material-ui/core/ClickAwayListener';
import MonetizationOnIcon from '@material-ui/icons/MonetizationOn';
import AddShoppingCartIcon from '@material-ui/icons/AddShoppingCart';


const drawerWidth = 280;
const theme = createMuiTheme({
  palette: {
    primary: {
      light: '#428e92',
      main: '#005f63',
      dark: '#003539',
      contrastText: '#fff',
    },
  },
});

const useStyles = makeStyles((theme) => ({
  root: {
    display: 'flex',
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
  },
  appBarShift: {
    marginLeft: drawerWidth,
    width: `calc(100% - ${drawerWidth}px)`,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  menuButton: {
    marginRight: 36,
  },
  hide: {
    display: 'none',
  },
  drawer: {
    width: drawerWidth,
    flexShrink: 0,
    whiteSpace: 'nowrap',
  },
  drawerOpen: {
    width: drawerWidth,
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  drawerClose: {
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    overflowX: 'hidden',
    width: theme.spacing(7) + 1,
    [theme.breakpoints.up('sm')]: {
      width: theme.spacing(9) + 1,
    },
  },
  toolbar: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'flex-end',
    padding: theme.spacing(0, 1),
    // necessary for content to be below app bar
    ...theme.mixins.toolbar,
  },
  content: {
    flexGrow: 1,
    padding: theme.spacing(3),
  },
}));


function CRUDProducts({  match , history }) {
    const classes = useStyles();
    const [productsPop,setProductsPop] = useState(1);
    const [incomeListPop,setIncomeListPop] = useState(0);
    const [bestSellersPop,setBestSellersPop] = useState(0);
    const [soldProductsPop,setSoldProductsPop] = useState(0);
    const [registeredUsersPop,setRegisteredUsersPop] = useState(0);
    const [currentPage, setCurrentPage] = useState(1);
    const [createEmployeePop,setCreateEmployeePop] = useState(0);
    const [usersListPop, setOrderPop] = useState(0);
    const [createRoleId,setCreateRoleId] = useState(0);
    const [employeesPop,setEmployeesPop] = useState(0);
    const [statusFilter, setStatusFilter] = useState('');
    const [eUsernameFilter, setEUsernameFilter] = useState('');
    const [eEmailFilter,setEEmailFilter] = useState('');
    const [roleFilter,setRoleFilter] = useState('');
    const [usernameFilter, setUsernameFilter] = useState('');
    const [emailFilter, setEmailFilter] = useState('');
    const [verifiedFilter, setVerifiedFilter] = useState('');
    const [tagfilter, setTagFilt] = useState([]);
    const [pricefilter, setPriceFilter] = React.useState([0, 150]);
    const [cisFilter, setCISFilter] = React.useState(3)
    const [ageFilter, setAgeFilter] = React.useState('ASC')
    const [fromDateFilter,setFromDateFilter] =  React.useState(new Date('2014-08-18T21:11:54'));
    const [toDateFilter,setToDateFilter] =  React.useState(new Date('2021-08-18T21:11:54'));
    const [searchfilter, setSearchFilter] = useState("");
    const [usersCount,setUsersCount] = useState([]);
    const [ordersCount,setOrdersCount] = useState([]);
    const [userOrdersPop,setUserOrdersPop] = useState(0);
    const [ordersPop,setOrdersPop] = useState(0);
    const [count,setCount] = useState([]);
    const [postsPerPage,setPostsPerPage] = useState(9);
    const [createUserPop,setCreateUserPop] = useState(false);
    const [changeStatusPop,setChangeStatusPop] = useState(false);
    const [createProductPop,setCreateProductPop] = useState(false);
    const [firstName,setFirstName] = useState('')
    const [secondName,setSecondName] = useState('')
    const [username,setUsername] = useState('');
    const [email,setEmail] = useState('');
    const [password,setPassword] = useState('');
    const [id,setid] = useState('');
    const [userId,setUserId] = useState('');
    const [name,setName] = useState('');
    const [price,setPrice] = useState('');
    const [employeeRole,setEmployeeROle] = useState('');
    const [image,setImage] = useState('');
    const [brand,setBrand] = useState('');
    const [newRole,setNewRole] = useState('');
    const [description,setDescription] = useState('');
    const [count_in_stock,setCountinstock] = useState('');
    const [eFirstName,setEFirstName] = useState('');
    const [eSecondName,setESecondName] = useState('');
    const [eUsername,setEUsername] = useState('');
    const [eEmail,setEEmail] = useState('');
    const [role,setRole] = useState(0);
    const [ePassword,setEPassword] = useState('');
    const [tag_id,setTag_id] = useState('');
    const [employeeId,setEmployeeId] = useState(0);
    const [changeRolePop,setChangeRolePop] = useState(0);
    const [orderId,setOrderId] = useState('');
    const [orderStatus,setOrderStatus] = useState('');
    const [newOrderStatus,setNewOrderStatus] = useState('');
    const employeeSignUp = useSelector((state)=>state.employeeSignUp);
    const {loading: loadingSaveEmployee,success: employeeSaved, error:employeeSaveError} = employeeSignUp;
    const productSave = useSelector((state)=>state.productSave);
    const {loading: loadingSave,success: productSaved, error:errorSave} = productSave;
    const productDelete = useSelector((state)=>state.productDelete);
    const {loading: loadingDelete,success: productDeleted, error:errorDelete} = productDelete;
    const productList = useSelector((state)=>state.productList);
    const {loading, products, error} = productList;
    const tagsList = useSelector((state) => state.tagsList);
    const { tags , loading: loadingTags, error: tagsError } = tagsList;
    const ptList = useSelector((state) => state.ptList);
    const { pts , loading: loadingPts, error: ptsError } = ptList;
    const usersList = useSelector((state) => state.usersList);
    const { users , loading: loadingUsers, error: usersError } = usersList;
    const employeesList = useSelector((state) => state.employeesList);
    const { employees , loading: loadingEmployees, error: employeesError } = employeesList;
    const userSignUp = useSelector((state) => state.userSignUp);
    const { success: userSignedUp, loading: SignUpLoading, error: SignUpError } = userSignUp;
    const ordersList = useSelector(state => state.ordersList);
    const { loading: ordersLoading, orders, error:ordersError } = ordersList;
    const [refreshState,setRefreshState] = useState(0);
    const employeeSignIn = useSelector(state=>state.employeeSignIn);
    const {employeeInfo, loading: employeesInfoLoading, error:employeesInfoError} = employeeSignIn;
    const [status,setStatus] = useState('');
    const dispatch = useDispatch();
    console.log(employeeInfo)
    const statuses = [{
      id: 1,
      name: "В процес на обработка"
    },
    {
      id: 2,
      name: "Изпратена"
    },
    {
      id: 3,
      name: "Получена"
    }
  ];

  const roles = [{
    id: 1,
    name: "viewer"
  },
{
  id: 2,
  name: "writer"
}];

    const theme = useTheme();
    const [open, setOpen] = React.useState(false);

    const handleDrawerOpen = () => {
      setOpen(true);
    };

    const handleDrawerClose = () => {
      setOpen(false);
    };

    const openStatusChangeBox = (order) => {
      setOrderStatus(order.order.order_status);
      setOrderId(order.order.id);
      setChangeStatusPop(true);
    }
    const openRoleChangeBox = (user) => {
      console.log("Employee Box",user)
      setEmployeeROle(user.user.role);
      setEmployeeId(user.user.id);
      setChangeRolePop(true);
    }
    console.log(pts)
    useEffect(() => {
        getCount();
        var userFilters = {
          filter: 0
        };
        var orderFilters = {
          filter: 0
        };
        var from = fromDateFilter.toLocaleString('en-GB', { timeZone: 'UTC' }).split(",")[0]
        var to = toDateFilter.toLocaleString('en-GB', { timeZone: 'UTC' }).split(",")[0]
        dispatch(listPT({currentPage,pricefilter,tagfilter,searchfilter,ageFilter,cisFilter,from,to}));
        dispatch(listProducts({currentPage,pricefilter,searchfilter,tagfilter,ageFilter,cisFilter,from,to}));
        dispatch(listUsers({verifiedFilter,emailFilter,usernameFilter,from,to,currentPage}));
        dispatch(listOrders(null,{currentPage,statusFilter,from,to}));
        dispatch(listEmployees({currentPage,eUsernameFilter,eEmailFilter,roleFilter}));

        if(userSignedUp){
            setCreateUserPop(false);
        }
        if(productSaved){
            setCreateProductPop(false);
        }
        if(employeeSaved){
            console.log(employeeSaved)
            setCreateEmployeePop(false);
        }
    },[refreshState,productSaved,statusFilter,verifiedFilter,emailFilter,usernameFilter,pricefilter,searchfilter,tagfilter,ageFilter,cisFilter,fromDateFilter,eEmailFilter,eUsernameFilter,roleFilter,toDateFilter,currentPage,userSignedUp]);
    console.log(ordersCount,usersCount)
    const getCount = async () => {

        try {
          var from = fromDateFilter.toLocaleString('en-GB', { timeZone: 'UTC' }).split(",")[0]
          var to = toDateFilter.toLocaleString('en-GB', { timeZone: 'UTC' }).split(",")[0]
            const orders_response = await fetch(`/orders/count`);
            const ordersc = await orders_response.json();
            setOrdersCount(ordersc[0]);
            const users_response = await fetch(`/users/count`);
            const usersc = await users_response.json();
            setUsersCount(usersc[0]);
            const response = await axios.post(`/products/getProductCount`,{tagfilter,cisFilter,ageFilter,pricefilter,searchfilter,to,from});
            setCount(response.data.max);
        } catch (err) {
          console.log(err.message);
        }
      }
      console.log(employees)
    const popCreateUserMenu = (user) => {
        setCreateUserPop(true);
        if(user.id){
            var names = (user.name).split(" ");
            console.log(names)
            setFirstName(names[0]);
            setSecondName(names[1]);
        }

        setUserId(user.id);
        setUsername(user.username);
        setName(user.name);
        setEmail(user.email);
    }

    const popCreateEmployeeMenu = (employee) => {
        setCreateEmployeePop(true);
        if(employee.id){
            var names = (employee.name).split(" ");
            console.log(names)
            setFirstName(names[0]);
            setSecondName(names[1]);
        }

        setUserId(employee.id);
        setUsername(employee.username);
        setName(employee.name);
        setEmail(employee.email);
    }


    const popCreateMenu = (product) => {
        if(product.id){
            var showtagsstring = '';
            var tagsstring = '';
            for(let i =0 ; i<pts.length;i++){
            if(i<pts.length){
                if(pts[i].product_id == product.id){
                    showtagsstring += pts[i].name + ',';
                    tagsstring += JSON.stringify(pts[i].tag_id) + ',';
                }
            }

            }
            tagsstring = tagsstring.substring(0, tagsstring.length - 1);
            showtagsstring = showtagsstring.substring(0, showtagsstring.length - 1);

        }
        setCreateProductPop(true);
        setName(product.name);
        setid(product.id);
        setPrice(product.price);
        setImage(product.image);
        setBrand(product.brand);
        if(product.id){
            setTag_id(showtagsstring);
        }else{
            setTag_id(product.tag_id);
        }
        setCountinstock(product.count_in_stock);
        setDescription(product.description);
    }


const submitStatusChange = (e) => {
  e.preventDefault();
  dispatch(updateStatus(newOrderStatus,orderId));
  setChangeStatusPop(false);
  console.log("NEW ORDER STATUS:",newOrderStatus)
  setRefreshState(!refreshState);
};

const submitRoleChange = (e) => {
  e.preventDefault();
  dispatch(updateRole(newRole,employeeId));
  setChangeRolePop(false);
  setRefreshState(!refreshState);
};
   const submitInfo = (e) => {
       e.preventDefault();
       var submitTags = '';
       var temptags = tag_id.split(',');
       for(let i =0 ; i<temptags.length;i++){
         for(let j =0;j<tags.length;j++){
           if(temptags[i] == tags[j].name){
               submitTags += JSON.stringify(tags[j].id) + ',';
           }
         }
       }
       submitTags = submitTags.substring(0, submitTags.length - 1);
       var currentdate = new Date();
       var create_date =  currentdate.getDate() + "/"
                + (currentdate.getMonth()+1)  + "/"
                + currentdate.getFullYear() + " @ "
                + currentdate.getHours() + ":"
                + currentdate.getMinutes() + ":"
                + currentdate.getSeconds();
       dispatch(saveProduct({create_date,id,name,price,image,brand,description,count_in_stock,submitTags}));
   };

   const submitUserInfo = (e) => {
    e.preventDefault();
    var update = 0;
    if(userId){
        update = 1;
    }
    dispatch(signup(firstName+" "+secondName,username,email,password,update,userId));
};

const submitEmployeeInfo = (e) => {
 e.preventDefault();
 var update = 0;
 if(employeeId){
     update = 1;
 }
 dispatch(employeesSignUp(eFirstName+" "+eSecondName,eUsername,eEmail,ePassword,createRoleId,update,employeeId));
};



   const deleteProductHandler = (product) => {

       dispatch(deleteProduct(product));
   }
   const handleOrdersButton = () => {
    if(usersListPop&&userOrdersPop){
        setUserOrdersPop(!userOrdersPop);
    }
    else{
        setOrderPop(!usersListPop);

    }
};
    const handleOrderListButton = () => {
        setOrdersPop(!ordersPop);
    }
    const handleSelectInterface = (key) => {
      setIncomeListPop(0);
      setRegisteredUsersPop(0);
      switch (key.text) {
        case 'Продукти':
          setEmployeesPop(0);
          setProductsPop(1);
          setOrdersPop(0);
          setUserOrdersPop(0);
          setOrderPop(0);
          break;
        case 'Потребители':
          setEmployeesPop(0);
          setProductsPop(0);
          setUserOrdersPop(0);
          setOrdersPop(0);
          setOrderPop(1);
          break;
        case 'Поръчки':
          setEmployeesPop(0);
          setProductsPop(0);
          setUserOrdersPop(0);
          setOrderPop(0);
          setOrdersPop(1);
          break;
        case 'Служители':
          setEmployeesPop(1);
          setProductsPop(0);
          setUserOrdersPop(0);
          setOrderPop(0);
          setOrdersPop(0);
          break;
        default:

      }
    }
    const handleSelectStat = (key) => {
      setProductsPop(0);
      setUserOrdersPop(0);
      setOrdersPop(0);
      setOrderPop(0);
      setEmployeesPop(0);
      switch (key.text) {
        case 'Поръчки':
          setIncomeListPop(1);
          setSoldProductsPop(0);
          setRegisteredUsersPop(0);
          setBestSellersPop(0);
          break;
        case 'Потребители':
          setIncomeListPop(0);
          setSoldProductsPop(0);
          setRegisteredUsersPop(1);
          setBestSellersPop(0);
          break;
        default:

      }
    }

const handleLogout = () => {
  Cookie.remove('employeeInfo');
  window.location = "/signinemp";
}

const handleUserOrdersButton = (user_id) => {
    dispatch(listOrders(user_id));

    setUserOrdersPop(!userOrdersPop);
};



   const paginate = (pageNumber) => setCurrentPage(pageNumber);
   const filterEUsername = (employeeUsername) => setEUsernameFilter(employeeUsername);
   const filterEEmail = (employeeEmail) => setEEmailFilter(employeeEmail);
   const filterRole = (role) => setRoleFilter(role);
   const filterVerified = (verified) => setVerifiedFilter(verified);
   const filterUsername = (userUsername) => setUsernameFilter(userUsername);
   const filterEmail = (userEmail) => setEmailFilter(userEmail);
   const filterTag = (tagid) => setTagFilt(tagid);
   const filterName = (search) => setSearchFilter(search);
   const filterPrice = (price) => setPriceFilter(price);
   const filterAge = (age) => setAgeFilter(age);
   const filterCIS = (count_in_stock) => setCISFilter(count_in_stock);
   const filterStatus = (orderStatus) => setStatusFilter(orderStatus);
   const filterFromDate = (fromDate) => setFromDateFilter(fromDate);
   const filterToDate = (toDate) => setToDateFilter(toDate);
   const [userFilters,setUserFilters] = useState({});
   const [orderFilters,setOrderFilters] = useState({});
   const [productFilters,setProductFilters] = useState({});


   var pagecount = parseInt(count / 9);
   if (count % 9 !== 0){
     pagecount = pagecount + 1;
   }
   var userpagecount = parseInt(usersCount.count / 9);
   if (usersCount.count%9!==0){
       userpagecount += 1;
   }
   var orderspagecount = parseInt(ordersCount.count / 9);
   if (ordersCount.count%9!==0){
    orderspagecount += 1;
   }
    return(
        <div>
              <div className={classes.root}>
       <CssBaseline />
       <AppBar
         position="fixed"
         className={clsx(classes.appBar, {
           [classes.appBarShift]: open,
         })}
       >
         <Toolbar>
           <IconButton
             color="inherit"
             aria-label="open drawer"
             onClick={handleDrawerOpen}
             edge="start"
             className={clsx(classes.menuButton, {
               [classes.hide]: open,
             })}
           >
             <MenuIcon />
           </IconButton>
           <Typography style = {{color:"white"}}variant="h6" noWrap>
             Бекофис
           </Typography>
         </Toolbar>
       </AppBar>
       <Drawer
         variant="permanent"
         className={clsx(classes.drawer, {
           [classes.drawerOpen]: open,
           [classes.drawerClose]: !open,
         })}
         classes={{
           paper: clsx({
             [classes.drawerOpen]: open,
             [classes.drawerClose]: !open,
           }),
         }}
       >
         <div className={classes.toolbar}>
           <IconButton onClick={handleDrawerClose}>
             {theme.direction === 'rtl' ? <ChevronRightIcon /> : <ChevronLeftIcon />}
           </IconButton>
         </div>
         <Divider />

         <List>
           <ListItem>
             <ListItemText inset="true">Интерфейси</ListItemText>
           </ListItem>
           {['Продукти', 'Потребители', 'Поръчки','Служители'].map((text, index) => (
             <ListItem onClick={() => handleSelectInterface({text})}
 button key={text}>
               <ListItemIcon>{index == 0 ? <MenuBookIcon/> : index == 1 ? <PersonIcon /> : index == 2 ? <LocalMallIcon/> : <PersonIcon />}</ListItemIcon>
               <ListItemText primary={text} />
             </ListItem>
           ))}
         </List>
         <Divider />
         <List>
           <ListItem>
             <ListItemText inset="true">Справки</ListItemText>
           </ListItem>
           {['Поръчки', 'Потребители'].map((text, index) => (
             <ListItem onClick={() => handleSelectStat({text})} button key={text}>
               <ListItemIcon>{index == 0 ? <MonetizationOnIcon/> : <PersonAddIcon /> }</ListItemIcon>
               <ListItemText primary={text} />
             </ListItem>
           ))}
         </List>
         <Divider />
         <List>
           <ListItem>
             <ListItemText inset="true">Други</ListItemText>
           </ListItem>
           {['Излез'].map((text, index) => (
             <ListItem onClick={() => handleLogout()} button key={text}>
               <ListItemIcon>{index == 0 ? <ExitToAppIcon/> : <PersonAddIcon /> }</ListItemIcon>
               <ListItemText primary={text} />
             </ListItem>
           ))}
         </List>
       </Drawer>
     </div>
     {(employeeInfo.perms).includes("View Employees Interface")&&employeesPop ? <div style={{marginTop: theme.spacing(10)}}><EmployeesFilters filterEEmail={filterEEmail} filterRole={filterRole} filterEUsername={filterEUsername}/> </div>: <div></div>}
     {(employeeInfo.perms).includes("View Users Interface")&&usersListPop ? <div style={{marginTop: theme.spacing(10)}}><UsersFilters filterEmail={filterEmail} filterVerified={filterVerified} filterUsername={filterUsername} filterFromDate={filterFromDate} filterToDate={filterToDate}/> </div>: <div></div>}
     {(employeeInfo.perms).includes("View Orders Interface")&&ordersPop ? <div style={{marginTop: theme.spacing(10)}}><OrdersFilters filterStatus={filterStatus} filterFromDate={filterFromDate} filterToDate={filterToDate} /> </div>: <div></div>}
     {(employeeInfo.perms).includes("View Product Interface")&&productsPop && !usersListPop ? <div style={{marginTop: theme.spacing(10)}}><ProductsFilters filterAge={filterAge} filterCIS={filterCIS} filterFromDate={filterFromDate} filterToDate={filterToDate} filterTag={filterTag} filterName={filterName} filterPrice={filterPrice}/> </div>: <div></div>}
        <div className="content content-margined">


            <div className="product-header">
           {(employeeInfo.perms).includes("View Product Interface")&&!employeesPop&&!usersListPop && !ordersPop ?  <Button
             style={{ marginRight: theme.spacing(2) }}
              variant="contained"
              color="primary"
             onClick={() => popCreateMenu({})}
              endIcon={<AddBoxIcon/>}
             >
                Създай Продукт
            </Button>  :<div></div>}
            {(employeeInfo.perms).includes("View Users Interface")&&usersListPop && !ordersPop ? <Button
            style={{ marginTop: theme.spacing(2) ,marginRight: theme.spacing(2) }}
              variant="contained"
              color="primary"
             onClick={() => popCreateUserMenu({})}
              endIcon={<AddBoxIcon/>}
             >
                Създай потребител
            </Button> : <div></div>}
            {(employeeInfo.perms).includes("View Orders Interface")&&ordersPop ? <Button
            style={{ marginTop: theme.spacing(10) ,marginRight: theme.spacing(2) }}
              variant="contained"
              color="primary"
             onClick={() => popCreateUserMenu({})}
              endIcon={<AddBoxIcon/>}
             >
                Създай поръчка
            </Button> : <div></div>}
            {(employeeInfo.perms).includes("View Employees Interface")&&employeesPop  ? <Button
            style={{ marginTop: theme.spacing(2) ,marginRight: theme.spacing(2) }}
              variant="contained"
              color="primary"
             onClick={() => popCreateEmployeeMenu({})}
              endIcon={<AddBoxIcon/>}
             >
                Нов служител
            </Button> : <div></div>}

            </div>
            {createProductPop && (<div className="signinform">
            <form onSubmit={submitInfo}>
                <ul className="form-container">

                    <li>
                        <h2>{id ?  "Обновяване на продукта" : "Нов Продукт"}</h2>
                    </li>
                    <li>
                        {loadingSave && <div>Loading...</div>}
                        {errorSave && <div>{errorSave}</div>}
                    </li>
                    <li>
                        <label htmlFor="name">
                            Име
                        </label>
                        <input type="text" name="name" id="name" value={name} onChange={(e) => setName(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="price">
                            Цена
                        </label>
                        <input type="number" step="any" name="price" id="price" value={price} onChange={(e) => setPrice(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="image">
                            Изображение
                        </label>
                        <input type="text" name="image" id="image" value={image} onChange={(e) => setImage(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="brand">
                            Модел
                        </label>
                        <input type="text" name="brand" id="brand" value={brand} onChange={(e) => setBrand(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="tag">
                            ID на категория
                        </label>
                        <input type="text" name="tag" id="tag" value={tag_id} onChange={(e) => setTag_id(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="cis">
                            Брой в наличност
                        </label>
                        <input type="number" name="cis" id="cis" value={count_in_stock} onChange={(e) => setCountinstock(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="description">
                            Описание
                        </label>
                        <textarea name="description" id="description" value={description} onChange={(e) => setDescription(e.target.value)}/>
                    </li>

                    <li>
                    <Button
                        variant="contained"
                        size="large"
                        color="primary"
                        type="submit"
                        endIcon={<AddBoxIcon/>}
                      >
                         {id ?  "Обнови Информацията за Продукта" : "Добави Нов Продукт"}
                    </Button>

                    </li>
                    <li>
                    <Button
                        onClick={() =>  setCreateProductPop(false)}
                        variant="contained"
                        size="large"
                        color="primary"
                        endIcon={<CancelIcon/>}
                      >
                        Затвори
                    </Button>
                    </li>
                </ul>
            </form>
        </div>)}
        {createUserPop && (<div className="signinform">
            <form onSubmit={submitUserInfo}>
                <ul className="form-container">

                    <li>
                        <h2>{userId ?  "Обновяване на потребител" : "Нов Потребител"}</h2>
                    </li>
                    <li>
                        {loadingSave && <div>Loading...</div>}
                        {errorSave && <div>{errorSave}</div>}
                    </li>
                    <li>
                        <label htmlFor="firstName">
                            Име
                        </label>
                        <input type="text" name="firstName" id="firstName" value={firstName} onChange={(e) => setFirstName(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="secondName">
                             Фамилия
                        </label>
                        <input type="text" name="secondName" id="secondName" value={secondName} onChange={(e) => setSecondName(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="username">
                            Потребителско Име
                        </label>
                        <input type="text" name="username" id="username" value={username} onChange={(e) => setUsername(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="email">
                            Имейл
                        </label>
                        <input type="email" name="email" id="email" value={email} onChange={(e) => setEmail(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="password">
                            Парола
                        </label>
                        <input type="password" name="password" id="password" value={password} onChange={(e) => setPassword(e.target.value)}/>
                    </li>
                    <li>
                    <Button
                        variant="contained"
                        size="large"
                        color="primary"
                        type="submit"
                        endIcon={<AddBoxIcon/>}
                      >
                         {userId ?  "Обнови Информацията за Потребителя" : "Добави нов потребител"}
                    </Button>

                    </li>
                    <li>
                    <Button
                        onClick={() =>  setCreateUserPop(false)}
                        variant="contained"
                        size="large"
                        color="primary"
                        endIcon={<CancelIcon/>}
                      >
                        Затвори
                    </Button>
                    </li>
                </ul>
            </form>
        </div>)}
        {createEmployeePop && (<div className="signinform">
            <form onSubmit={submitEmployeeInfo}>
                <ul className="form-container">

                    <li>
                        <h2>{employeeId ?  "Обновяване на служител" : "Нов Служител"}</h2>
                    </li>
                    <li>
                        {loadingSave && <div>Loading...</div>}
                        {errorSave && <div>{errorSave}</div>}
                    </li>
                    <li>
                        <label htmlFor="firstName">
                            Име
                        </label>
                        <input type="text" name="firstName" id="firstName" value={eFirstName} onChange={(e) => setEFirstName(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="secondName">
                             Фамилия
                        </label>
                        <input type="text" name="secondName" id="secondName" value={eSecondName} onChange={(e) => setESecondName(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="username">
                            Потребителско Име
                        </label>
                        <input type="text" name="username" id="username" value={eUsername} onChange={(e) => setEUsername(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="email">
                            Имейл
                        </label>
                        <input type="email" name="email" id="email" value={eEmail} onChange={(e) => setEEmail(e.target.value)}/>
                    </li>
                    <li>
                    <label htmlFor="role">
                        Роля
                    </label>
                      <select required style={{fontSize:"20px"}}  name="role" id="role" onChange={(e) => setCreateRoleId(e.target.value)} name="statuses" id="statuses">
                           <option style={{fontSize:"15px"}} disabled selected="selected"> -- select an option -- </option>
                                {roles.map(status => (
                                  (status.name!=orderStatus)?
                            <option  style={{fontSize:"15px"}}  value={status.id}>{status.name}</option>
                                  :<div></div>  ))}
                      </select>
                    </li>
                    <li>
                        <label htmlFor="password">
                            Парола
                        </label>
                        <input type="password" name="password" id="password" value={ePassword} onChange={(e) => setEPassword(e.target.value)}/>
                    </li>
                    <li>
                    <Button
                        variant="contained"
                        size="large"
                        color="primary"
                        type="submit"
                        endIcon={<AddBoxIcon/>}
                      >
                         {userId ?  "Обнови Информацията за Служителя" : "Добави нов служител"}
                    </Button>

                    </li>
                    <li>
                    <Button
                        onClick={() =>  setCreateEmployeePop(false)}
                        variant="contained"
                        size="large"
                        color="primary"
                        endIcon={<CancelIcon/>}
                      >
                        Затвори
                    </Button>
                    </li>
                </ul>
            </form>
        </div>)}
        {changeStatusPop && (<div className="signinform">
            <form onSubmit={submitStatusChange}>
                <ul className="form-container">

                    <li>
                        <h2> Обновяване на статуса на поръчката</h2>
                    </li>
                    <li>
                      <label htmlFor="status">
                          Текущ статус:
                      </label>
                      <input disabled type="text" name="status" id="status" value={orderStatus} />

                    </li>
                    <li>
                      <label for="statuses">Избери нов статус:</label>

                      <select onChange={(e) => setNewOrderStatus(e.target.value)} name="statuses" id="statuses">
                         <option disabled selected="selected"> -- select an option -- </option>
                        {statuses.map(status => (
                        (status.name!=orderStatus)?
                        <option  value={status.name}>{status.name}</option>
                    :<div></div>  ))}
                      </select>
                    </li>
                    <li>
                    <Button
                        variant="contained"
                        size="large"
                        color="primary"
                        type="submit"
                        endIcon={<AddBoxIcon/>}
                      >
                          Обнови Статуса на Поръчката
                    </Button>

                    </li>
                    <li>
                    <Button
                        onClick={() =>  setChangeStatusPop(false)}
                        variant="contained"
                        size="large"
                        color="primary"
                        endIcon={<CancelIcon/>}
                      >
                        Затвори
                    </Button>
                    </li>
                </ul>
            </form>
        </div>)}
        {changeRolePop && (<div className="signinform">
            <form onSubmit={submitRoleChange}>
                <ul className="form-container">

                    <li>
                        <h2> Обновяване на ролята на служителя</h2>
                    </li>
                    <li>
                      <label htmlFor="status">
                          Текуща роля:
                      </label>
                      <input disabled type="text" name="status" id="status" value={employeeRole} />

                    </li>
                    <li>
                      <label for="roles">Избери нова роля:</label>

                      <select onChange={(e) => setNewRole(e.target.value)} name="roles" id="roles">
                         <option disabled selected="selected"> -- select an option -- </option>
                        {roles.map(status => (
                        (status.name!=orderStatus)?
                        <option  value={status.id}>{status.name}</option>
                    :<div></div>  ))}
                      </select>
                    </li>
                    <li>
                    <Button
                        variant="contained"
                        size="large"
                        color="primary"
                        type="submit"
                        endIcon={<AddBoxIcon/>}
                      >
                          Обнови Ролята на Служителя
                    </Button>

                    </li>
                    <li>
                    <Button
                        onClick={() =>  setChangeRolePop(false)}
                        variant="contained"
                        size="large"
                        color="primary"
                        endIcon={<CancelIcon/>}
                      >
                        Затвори
                    </Button>
                    </li>
                </ul>
            </form>
        </div>)}
        {(employeeInfo.perms).includes("View Product Interface")&&productsPop && <h2 style={{marginLeft:"60px"}}>Брой продукти отговарящи на търсенето: {count} </h2>}
            {productsPop&& !ordersPop && !userOrdersPop && !usersListPop&& products&&
            (<div className="product-list">
                <table className="table">
                    <thead>
                        <tr>
                            <th>
                                Дата на създаване
                            </th>
                            <th>
                                Последно обновен
                            </th>
                            <th>
                                Име
                            </th>
                            <th>
                                Цена
                            </th>
                            <th>
                                Изображение
                            </th>
                            <th>
                                Жанрове
                            </th>
                            <th>
                                Брой в наличност
                            </th>
                            <th>
                                Описание
                            </th>
                            <th>
                                Модел
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {pts && products.map(product => (
                            <tr key={product.id}>
                            <td>
                                 {(product.create_date).split("T").join(" ").slice(0,-5)}
                            </td>
                            <td>
                                 {product.edit_time!=null ? <div> {(product.edit_time).split("T").join(" ").slice(0,-5)} </div>:<div></div>}
                            </td>
                            <td>
                                 {product.name}
                            </td>
                            <td align="right">
                                 {Number(product.price).toFixed(2)} {product.currency_id}
                            </td>
                            <td>
                                 {product.image}
                            </td>
                            <td>
                             {pts.map(pt => (

                                pt.product_id == product.id ? <div>
                                    {pt.name}
                                </div> : <div></div>

                                ))}
                            </td>
                            <td align="right">
                                 {product.count_in_stock}
                            </td>
                            <td>
                                 {product.description}
                            </td>
                            <td>
                                 {product.brand}
                            </td>
                            <th>
                            <Button
                                onClick={() => popCreateMenu(product)}
                                variant="contained"
                                size="large"
                                color="primary"
                                endIcon={<EditIcon/>}>
                                Обнови
                            </Button>
                            <Button
                                onClick={() => deleteProductHandler(product)}
                                variant="contained"
                                size="large"
                                color="secondary"
                                endIcon={<DeleteForeverIcon/>}>
                                Скрий
                            </Button>
                            </th>
                        </tr>
                        ))}



                    </tbody>
                </table>
            </div>)}
            {(employeeInfo.perms).includes("View Users Interface")&&!ordersPop && !userOrdersPop && usersListPop&& products&&
            (<div className="product-list">
                <table className="table">
                    <thead>
                        <tr>
                            <th>
                                Дата на регистрация
                            </th>
                            <th>
                                Име
                            </th>

                            <th>
                                Потребителско име
                            </th>
                            <th>
                                E-mail
                            </th>
                            <th>
                              Потвърден
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {users.map(user => (
                            <tr key={user.id}>
                            <td>
                                {(user.create_date).split("T").join(" ").slice(0,-5)}
                            </td>
                            <td>
                                 {user.name}
                            </td>
                            <td>
                                 {user.username}
                            </td>
                            <td>
                                 {user.email}
                            </td>
                            <td>
                              {(user.verified).toString()=='true' ? <div>Да</div> : <div>Не</div>}
                            </td>

                            <th>
                            <Button
                                onClick={() => popCreateUserMenu(user)}
                                variant="contained"
                                size="large"
                                color="primary"
                                endIcon={<EditIcon/>}>
                                Обнови
                            </Button>
                            <Button
                                onClick={() => handleUserOrdersButton(user.id)}
                                variant="contained"
                                size="large"
                                color="secondary"
                                endIcon={<StoreIcon/>}>
                                Поръчки
                            </Button>
                            </th>
                        </tr>
                        ))}



                    </tbody>
                </table>
            </div>)}
            {(employeeInfo.perms).includes("View Employees Interface")&&employeesPop&&
            (<div className="product-list">
                <table className="table">
                    <thead>
                        <tr>
                            <th>
                                Име
                            </th>

                            <th>
                                Потребителско име
                            </th>
                            <th>
                                E-mail
                            </th>
                            <th>
                                Роля
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {employees.map(user => (
                            <tr key={user.id}>
                            <td>
                                 {user.name}
                            </td>
                            <td>
                                 {user.username}
                            </td>
                            <td>
                                 {user.email}
                            </td>
                            <td>
                              {user.role}
                            </td>

                            <th>
                              <Can
  role={employeeInfo.role}
  perform="dashboard-page:visit"
  yes={() => (
    <Button
     style = {{marginLeft:"20px"}}
     variant="contained"
     size="large"
     color="secondary"
     onClick={() => openRoleChangeBox({user})}
     endIcon={<EditIcon/>}>
     Промени Ролята на Служителя

 </Button>
  )}
  no={() => <div></div>}
/>


                            </th>
                        </tr>
                        ))}



                    </tbody>
                </table>
            </div>)}
            {(employeeInfo.perms).includes("View Users Interface")&&!ordersPop && userOrdersPop&& products&&
            (<div className="product-list">
                <table className="table">
                    <thead>
                        <tr>
                          <th>
                           Направена на
                          </th>
                          <th>
                            Име на потребителя
                          </th>
                          <th>
                            Потребителско име
                          </th>
                          <th>
                            Имейл на потребителя
                          </th>
                          <th>
                            Адрес за доставка
                          </th>
                          <th>
                           Обща сума на поръчката

                          </th>

                          <th>
                              Статус на поръчката
                          </th>
                          <th>
                              Продукти
                          </th>
                            <th>
                               Допълнителна информация за поръчката
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {orders.map(order => (
                            <tr key={order.id}>
                              <td>
                              {(order.created).split("T").join(" ").slice(0,-5)}
                              </td>
                              <td>
                                {order.name}
                              </td>
                              <td>
                                {order.username}
                              </td>
                              <td>
                                {order.email}
                              </td>
                              <td>
                                {order.address}
                              </td>
                              <td align="right">
                                  {order.price} {order.currency}
                              </td>

                              <td>
                              {order.order_status}
                              </td>
                              <td>
                                {order.string_agg}
                              </td>
                            <th>
                              <Button
                               style = {{marginLeft:"20px"}}
                               variant="contained"
                               size="large"
                               color="secondary"
                               onClick={() => openStatusChangeBox({order})}
                               endIcon={<EditIcon/>}>
                               Статус
                           </Button>
                            <Link to={"/order/" + order.id}>
                            <Button
                                variant="contained"
                                size="large"
                                color="primary"
                                endIcon={<EditIcon/>}>
                                Детайли за поръчката
                            </Button>
                            </Link>

                            </th>
                        </tr>
                        ))}





                    </tbody>
                </table>
            </div>)}
            {(employeeInfo.perms).includes("View Orders Interface")&&ordersPop &&
            (<div className="product-list">
                <table className="table">
                    <thead>
                        <tr>
                          <th>
                           Направена на
                          </th>
                          <th>
                            Име на потребителя
                          </th>
                          <th>
                            Потребителско име
                          </th>
                          <th>
                            Имейл на потребителя
                          </th>
                          <th>
                            Адрес за доставка
                          </th>
                          <th>
                           Обща сума на поръчката

                          </th>

                          <th>
                              Статус на поръчката
                          </th>
                          <th>
                              Продукти
                          </th>
                          <th>
                            Допълнителна информация
                          </th>
                        </tr>
                    </thead>
                    <tbody>
                        {orders.map(order => (
                            <tr key={order.id}>
                              <td>
                              {(order.created).split("T").join(" ").slice(0,-5)}
                              </td>
                              <td>
                                {order.name}
                              </td>
                              <td>
                                {order.username}
                              </td>
                              <td>
                                {order.email}
                              </td>
                              <td>
                                {order.address}
                              </td>
                              <td align="right">
                                  {order.price} {order.currency}
                              </td>

                              <td>
                              {order.order_status}
                              </td>
                              <td>
                                {order.string_agg}
                              </td>
                            <th>
                              <Button
                               style = {{marginLeft:"20px"}}
                               variant="contained"
                               size="large"
                               color="secondary"
                               onClick={() => openStatusChangeBox({order})}
                               endIcon={<EditIcon/>}>
                               Статус
                           </Button>
                            <Link to={"/order/" + order.id}>
                            <Button
                                variant="contained"
                                size="large"
                                color="primary"
                                endIcon={<EditIcon/>}>
                                Детайли за поръчката
                            </Button>
                            </Link>

                            </th>
                        </tr>
                        ))}





                    </tbody>
                </table>
            </div>)}
            {(employeeInfo.perms).includes("View Stats")? <BackOfficeStats bestSellers = {bestSellersPop} income={incomeListPop} registeredUsers={registeredUsersPop} soldProducts={soldProductsPop}/> :<div></div>}

        </div>

        {(employeeInfo.perms).includes("View Orders Interface") && ordersPop ? <CRUDPagination postsPerPage={postsPerPage} totalPosts={orderspagecount} paginate={paginate} /> : <div></div>}
        {(employeeInfo.perms).includes("View Users Interface") &&!ordersPop &&usersListPop ? <CRUDPagination postsPerPage={postsPerPage} totalPosts={userpagecount} paginate={paginate} /> : <div></div>}
        {(employeeInfo.perms).includes("View Product Interface") && productsPop && !ordersPop && !usersListPop ? <CRUDPagination postsPerPage={postsPerPage} totalPosts={pagecount} paginate={paginate} /> : <div></div>}
        </div>

    );
}

export default CRUDProducts;
