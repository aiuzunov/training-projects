import React from 'react';
import './App.css';
import NavBar from './NavBar';
import Shop from './Shop';
import {BrowserRouter as Router, Switch, Route} from 'react-router-dom';
import ItemDetail from './ItemDetail';
import NestedGrid from './NestedGrid';
import BasicPagination from './BasicPagination';

function App() {
  return (
    <Router>
    <div className="App">
     <NavBar />
      <Switch>
     <Route path="/" exact component={Home}/>

     <Route path="/" exact component={Shop}/>
     <Route path="/shop/:id" component={ItemDetail}/>
     </Switch>
     <BasicPagination />
     <footer> All Rights Reserved </footer>
    </div>
    </Router>
    
  );
}
const Home = () => (
  <div>
    <h1>
      Списък с продукти
    </h1>
  </div>
);

export default App;
