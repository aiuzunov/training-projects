import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct, saveProduct, listProducts, deleteProduct } from './actions/productActions';
import { Link } from 'react-router-dom';
import { signin, listUsers } from './actions/userActions';
import Pagination from '@material-ui/lab/Pagination';
import CRUDPagination from './CRUDPagination';
import NavBar from './NavBar';
import AddBoxIcon from '@material-ui/icons/AddBox';
import { Button, Icon } from '@material-ui/core';
import CancelIcon from '@material-ui/icons/Cancel';
import EditIcon from '@material-ui/icons/Edit';
import DeleteForeverIcon from '@material-ui/icons/DeleteForever';
import { listTags } from './actions/tagsActions';
import BackOfficeFilters from './BackOfficeFilters';
import { listPT } from './actions/ptActions';
import StoreIcon from '@material-ui/icons/Store';



function CRUDProducts({  match , history }) {
    const [currentPage, setCurrentPage] = useState(1);
    const [orderPop, setOrderPop] = useState(0);
    const [tagfilter, setTagFilt] = useState('');
    const [pricefilter, setPriceFilter] = React.useState([0, 150]);
    const [searchfilter, setSearchFilter] = useState("");
    const [usersCount,setUsersCount] = useState([]);
    const [userOrdersPop,setUserOrdersPop] = useState(0);
    const [count,setCount] = useState([]);
    const [postsPerPage,setPostsPerPage] = useState(9);
    const [createProductPop,setCreateProductPop] = useState(false);
    const [id,setid] = useState('')
    const [name,setName] = useState('');
    const [price,setPrice] = useState('');
    const [image,setImage] = useState('');
    const [brand,setBrand] = useState('');
    const [description,setDescription] = useState('');
    const [count_in_stock,setCountinstock] = useState('');
    const [tag_id,setTag_id] = useState('');
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
    const dispatch = useDispatch();
      
    useEffect(() => {
        getCount()
        dispatch(listProducts(pricefilter,tagfilter,searchfilter,currentPage,loadingPts));
        dispatch(listPT(currentPage));
        dispatch(listUsers(currentPage));



        if(productSaved){
            setCreateProductPop(false);
        }
    },[productSaved,pricefilter,tagfilter,searchfilter,currentPage]);
    console.log(users)

    const getCount = async () => {

        try {
            const users_response = await fetch(`http://localhost:5000/api/users/count`);
            const usersc = await users_response.json();
            setUsersCount(usersc);
            if(searchfilter&&tagfilter&&pricefilter){
            const response = await fetch(`http://localhost:5000/api/products/${searchfilter}/${tagfilter}/${pricefilter}`);
            const count = await response.json();
            setCount(count);
          }
          else if(searchfilter&&pricefilter){
            const response = await fetch(`http://localhost:5000/api/products/${searchfilter}/${pricefilter}`);
            const count = await response.json();
            setCount(count);
          }
          else if(tagfilter&&pricefilter){
            const response = await fetch(`http://localhost:5000/api/products/${tagfilter}/${pricefilter}`);
            const count = await response.json();
            setCount(count);
          }
          else if(pricefilter){
            const response = await fetch(`http://localhost:5000/api/products/${pricefilter}`);
            const count = await response.json();
            setCount(count);
          }
    
        } catch (err) {
          console.log(err.message);
        }
      }

    const popCreateMenu = (product) => {
        if(product.id){
            var tagsstring = ''
            for(let i =0 ; i<pts.length;i++){
            if(i<pts.length){
                if(pts[i].product_id == product.id){
                    tagsstring += JSON.stringify(pts[i].id) + ',';
                }
            }

            }
            tagsstring = tagsstring.substring(0, tagsstring.length - 1);

        }
        setCreateProductPop(true);
        setName(product.name);
        setid(product.id);
        setPrice(product.price);
        setImage(product.image);
        setBrand(product.brand);
        if(product.id){
            setTag_id(tagsstring);
        }else{
            setTag_id(product.tag_id);
        }
        setCountinstock(product.count_in_stock);
        setDescription(product.description);
    }
  

   const submitInfo = (e) => {
       e.preventDefault();
       var currentdate = new Date(); 
       var create_date =  currentdate.getDate() + "/"
                + (currentdate.getMonth()+1)  + "/" 
                + currentdate.getFullYear() + " @ "  
                + currentdate.getHours() + ":"  
                + currentdate.getMinutes() + ":" 
                + currentdate.getSeconds();
       dispatch(saveProduct({create_date,id,name,price,image,brand,description,count_in_stock,tag_id}));
   };

   const deleteProductHandler = (product) => {
       
       dispatch(deleteProduct(product));
   }
   const handleOrdersButton = () => {
    setOrderPop(!orderPop);
};

const handleUserOrdersButton = () => {
    console.log(userOrdersPop)
    setUserOrdersPop(!userOrdersPop);
};

   const paginate = (pageNumber) => setCurrentPage(pageNumber);
   const filterTag = (tagid) => setTagFilt(tagid);
   const filterName = (search) => setSearchFilter(search);
   const filterPrice = (price) => setPriceFilter(price);
    
   var pagecount = parseInt(count.count / 9);
   if (count.count % 9 !== 0){
     pagecount = pagecount + 1;
   }
   var userpagecount = parseInt(usersCount.count / 9);
   if (usersCount.count%9!==0){
       userpagecount += 1;
   }
    return(
        <div>
            <NavBar/>
            {!orderPop && <BackOfficeFilters filterTag={filterTag} filterName={filterName} filterPrice={filterPrice}  pageNumber={currentPage} saved ={productSaved} deleted={productDeleted} />}
        <div className="content content-margined">
          
            <div className="product-header">
           {!orderPop && <Button
              variant="contained"
              color="primary"
             onClick={() => popCreateMenu({})}
              endIcon={<AddBoxIcon/>}
             >
                Нов Продукт
            </Button>}
            <Button
              variant="contained"
              color="primary"
             onClick={() => handleOrdersButton({})}
              startIcon={<StoreIcon/>}
             >
                {orderPop ? <div>Продукти</div> :<div>Потребители</div>}
            </Button>
              
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
            {!userOrdersPop && !orderPop&& products&&
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
                                 {product.create_date}
                            </td>
                            <td>
                                 {product.edit_time}
                            </td>
                            <td>
                                 {product.name}
                            </td>
                            <td>
                                 {Number(product.price).toFixed(2)}
                            </td>
                            <td>
                                 {product.image}
                            </td>
                            <td>
                             {pts.map(pt => (
                              
                                pt.product_id == product.id ? <div>
                                    {pt.name}
                                </div> : <div> </div>
                                
                                ))}
                            </td>
                            <td>
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
                                Изтрий
                            </Button>
                            </th>
                        </tr>
                        ))}
                        
                      
                    
                    </tbody> 
                </table>
            </div>)}
            {!userOrdersPop && orderPop&& products&&
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
                        </tr>
                    </thead>
                    <tbody>
                        {users.map(user => (
                            <tr key={user.id}>
                            <td>
                                {user.create_date}
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
                           
                            <th>
                            <Button
                                variant="contained"
                                size="large"
                                color="primary"
                                endIcon={<EditIcon/>}>
                                Обнови
                            </Button>
                            <Button
                                onClick={() => handleUserOrdersButton()}
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
            {userOrdersPop&& products&&
            (<div className="product-list">
                <table className="table">
                    <thead>
                        <tr> 
                            <th>
                                id на поръчката
                            </th>
                            <th>
                                Сума 
                            </th>
                           
                            <th>
                                Статус на поръчката
                            </th>
                            <th>
                                Продукти
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {users.map(user => (
                            <tr key={user.id}>
                            <td>
                                In progress
                            </td>
                            <td>
                                 In progress
                            </td>
                            <td>
                            In progress
                            </td>
                            <td>
                            In progress
                            </td>
                           
                            <th>
                            <Button
                                variant="contained"
                                size="large"
                                color="primary"
                                endIcon={<EditIcon/>}>
                                Обнови
                            </Button>
                            <Button
                                onClick={() => handleUserOrdersButton({})}
                                
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
        </div>
        
        {orderPop && <CRUDPagination postsPerPage={postsPerPage} totalPosts={userpagecount} paginate={paginate} />}
        {!orderPop && <CRUDPagination postsPerPage={postsPerPage} totalPosts={pagecount} paginate={paginate} />}
        </div>
        
    );
}

export default CRUDProducts;