import React from 'react';
import { fade, makeStyles } from '@material-ui/core/styles';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import IconButton from '@material-ui/core/IconButton';
import Typography from '@material-ui/core/Typography';
import InputBase from '@material-ui/core/InputBase';
import Badge from '@material-ui/core/Badge';
import MenuItem from '@material-ui/core/MenuItem';
import Menu from '@material-ui/core/Menu';
import SearchIcon from '@material-ui/icons/Search';
import AccountCircle from '@material-ui/icons/AccountCircle';
import ShoppingCartIcon from '@material-ui/icons/ShoppingCart';
import HomeIcon from '@material-ui/icons/Home';
import CategoryIcon from '@material-ui/icons/Category';
import { createMuiTheme } from '@material-ui/core/styles';
import { ThemeProvider } from '@material-ui/styles';
import BasicPagination from './BasicPagination';
import {useEffect,useState} from  'react';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import {Link, NavLink} from 'react-router-dom';
import { useSelector, useDispatch } from 'react-redux';
import { listProducts } from './actions/productActions';
import Cookie from 'js-cookie';





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
  grow: {
    flexGrow: 1,
  },
  menuButton: {
    marginRight: theme.spacing(2),
  },
  title: {
    color:'#fff',
    display: 'none',
    textDecoration: 'none',
    [theme.breakpoints.up('sm')]: {
      display: 'block',
    },
  },
  search: {
    position: 'relative',
    borderRadius: theme.shape.borderRadius,
    backgroundColor: fade(theme.palette.common.white, 0.15),
    '&:hover': {
      backgroundColor: fade(theme.palette.common.white, 0.25),
    },
    marginRight: theme.spacing(2),
    marginLeft: 0,
    width: '100%',
    [theme.breakpoints.up('sm')]: {
      marginLeft: theme.spacing(3),
      width: 'auto',
    },
  },
  searchIcon: {
    padding: theme.spacing(0, 2),
    height: '100%',
    position: 'absolute',
    pointerEvents: 'none',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
  },
  inputRoot: {
    color: 'inherit',
  },
  inputInput: {
    padding: theme.spacing(1, 1, 1, 0),
    // vertical padding + font size from searchIcon
    paddingLeft: `calc(1em + ${theme.spacing(4)}px)`,
    transition: theme.transitions.create('width'),
    width: '100%',
    [theme.breakpoints.up('md')]: {
      width: '20ch',
    },
  },
  sectionDesktop: {
    display: 'none',
    alignItems: 'center',
    [theme.breakpoints.up('md')]: {
      display: 'flex',
    },
  },
  sectionMobile: {
    display: 'flex',
    [theme.breakpoints.up('md')]: {
      display: 'none',
    },
  },
 
}));

function NavBar(props) {
  const classes = useStyles();
  const [navAnchorEl,setNavAnchorEl] = React.useState(null);
  const [anchorEl, setAnchorEl] = React.useState(null);
  const [mobileMoreAnchorEl, setMobileMoreAnchorEl] = React.useState(null);
  const isNavMenuOpen = Boolean(navAnchorEl);
  const isProfileMenuOpen = Boolean(anchorEl);
  const isProfileMobileMenuOpen = Boolean(mobileMoreAnchorEl);
  const userSignIn = useSelector(state=>state.userSignIn);
  const {userInfo} = userSignIn;
  const loggedIn = Cookie.getJSON('userInfo') || null;

 
  const handleNavMenuOpen = (event) => {
    setNavAnchorEl(event.currentTarget);
  };

  const handleNavMenuClose = () => {
    setNavAnchorEl(null);
  };

  const handleProfileMenuOpen = (event) => {
    setAnchorEl(event.currentTarget);
  };

  const handleMobileMenuClose = () => {
    setMobileMoreAnchorEl(null);
  };

  const handleMenuClose = () => {
    setAnchorEl(null);
    handleMobileMenuClose();
  };

  const handleMobileMenuOpen = (event) => {
    setMobileMoreAnchorEl(event.currentTarget);
  };
  const NavMenu = 'primary-navbar-search-menu'
  const renderNavMenu =(
    <Menu
    anchorEl={navAnchorEl}
    anchorOrigin={{ vertical: 'top', horizontal: 'left' }}
    id={NavMenu}
    keepMounted
    transformOrigin={{ vertical: 'top', horizontal: 'left' }}
    open={isNavMenuOpen}
    onClose={handleNavMenuClose}
  >
    <MenuItem onClick={handleMenuClose}>Categories</MenuItem>
    <MenuItem onClick={handleMenuClose}>Orders</MenuItem>
  </Menu>
);

  const ProfileMenuId = 'primary-search-account-menu';
 
  const renderProfileMenu = (
    
    <Menu
      anchorEl={anchorEl}
      anchorOrigin={{ vertical: 'top', horizontal: 'right' }}
      id={ProfileMenuId}
      keepMounted
      transformOrigin={{ vertical: 'top', horizontal: 'right' }}
      open={isProfileMenuOpen}
      onClose={handleMenuClose}
    >
      <Link style={{ textDecoration: 'none' }} to="/signin">
      <MenuItem style={{ color: '#000' }} onClick={handleMenuClose}>Влизане</MenuItem>
      </Link> 
      <Link style={{ textDecoration: 'none' }} to="/signup">
      <MenuItem style={{ color: '#000' }} onClick={handleMenuClose}>Регистрация</MenuItem>
      </Link>
    </Menu>
  );

  const mobileMenuId = 'primary-search-account-menu-mobile';
  const renderMobileProfileMenu = (
    <Menu
      anchorEl={mobileMoreAnchorEl}
      anchorOrigin={{ vertical: 'top', horizontal: 'right' }}
      id={mobileMenuId}
      keepMounted
      transformOrigin={{ vertical: 'top', horizontal: 'right' }}
      open={isProfileMobileMenuOpen}
      onClose={handleMobileMenuClose}
    >
      <MenuItem>
        <IconButton  color="inherit">
            <ShoppingCartIcon />
        </IconButton>
        <p>ShoppingCart</p>
      </MenuItem>
      <MenuItem onClick={handleProfileMenuOpen}>
        <IconButton
          aria-label="account of current user"
          aria-controls="primary-search-account-menu"
          aria-haspopup="true"
          color="inherit"
        >
          <AccountCircle />
        </IconButton>
        <p>Login/Register</p>
      </MenuItem>
    </Menu>
  );


  return (
   
    <div className={classes.grow}>
      <ThemeProvider theme={theme}>
      <AppBar position="relative" color="primary">
        <Toolbar>
        <Link to="/" >
          <IconButton
            style={{ color: '#FFF' }}
            edge="start"
            aria-controls={NavMenu}
            aria-haspopup="true"
            aria-label="open drawer"
          >
            <HomeIcon />
          </IconButton>
          </Link>
         
          <Typography className={classes.title} variant="h6" noWrap>
            Онлайн Магазин
          </Typography>
          
         
         
          <div className={classes.grow} />
          <div className={classes.sectionDesktop}>
          <Link to="/cart" style={{ color: '#FFF' }} >
            <IconButton color="inherit">
                <ShoppingCartIcon />
            </IconButton>
          </Link> 
            {loggedIn ? <Link to="/profile" style={{ textDecoration: 'none' }}> <Typography className={classes.title} variant="h6" noWrap>
            {userInfo.username}
          </Typography></Link> : 
            <IconButton
              edge="end"
              aria-label="account of current user"
              aria-controls={ProfileMenuId}
              aria-haspopup="true"
              onClick={handleProfileMenuOpen}
              color="inherit"
            >
              <AccountCircle />
            </IconButton>}
          </div>
          <div className={classes.sectionMobile}>
            <IconButton
              aria-label="show more"
              aria-controls={mobileMenuId}
              aria-haspopup="true"
              onClick={handleMobileMenuOpen}
              color="inherit"
            >
           
            </IconButton>
          </div>
        </Toolbar>
      </AppBar>
      </ThemeProvider>
      {renderMobileProfileMenu}
      {renderProfileMenu}
      {renderNavMenu}

    </div>
  );
  
}

export default NavBar;

