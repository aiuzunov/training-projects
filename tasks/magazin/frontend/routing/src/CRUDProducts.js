import React, { useCallback } from 'react';
import { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { detailsProduct, saveProduct, listProducts } from './actions/productActions';
import { Link } from 'react-router-dom';
import { signin } from './actions/userActions';
import Pagination from '@material-ui/lab/Pagination';
import CRUDPagination from './CRUDPagination';



function CRUDProducts({  match , history }) {
    const [currentPage, setCurrentPage] = useState(1);
    const [postsPerPage,setPostsPerPage] = useState(10);
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
    const productList = useSelector((state)=>state.productList);
    const {loading, products, error} = productList;
    const dispatch = useDispatch();
    useEffect(() => {
        if(productSaved){
            setCreateProductPop(false);
        }
        dispatch(listProducts());

    },[productSaved]);
    
    const indexOfLastPost = currentPage * postsPerPage;
    const indexOfFirstPost = indexOfLastPost - postsPerPage;
    const currentPosts = products.slice(indexOfFirstPost, indexOfLastPost)

    const popCreateMenu = (product) => {
        setCreateProductPop(true);
        setName(product.name);
        setid(product.id);
        setPrice(product.price);
        setImage(product.image);
        setBrand(product.brand);
        setTag_id(product.tag_id);
        setCountinstock(product.count_in_stock);
        setDescription(product.description);
    }

   const submitInfo = (e) => {
       e.preventDefault();
       
       dispatch(saveProduct({id,name,price,image,brand,description,count_in_stock,tag_id}));
   };

   const paginate = (pageNumber) => setCurrentPage(pageNumber);
 
    return(
        <div className="content content-margined">
            <div className="product-header">
                <h3>Options</h3>
                <button onClick={() => popCreateMenu({})}>Create Product</button>
            </div>
            {createProductPop && (<div className="signinform">
            <form onSubmit={submitInfo}>
                <ul className="form-container">
                    <li>
                        <h2>Create Product</h2>
                    </li>
                    <li>
                        {loadingSave && <div>Loading...</div>}
                        {errorSave && <div>{errorSave}</div>}
                    </li>
                    <li>
                        <label htmlFor="name">
                            Name
                        </label>
                        <input type="text" name="name" id="name" value={name} onChange={(e) => setName(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="price">
                            Price
                        </label>
                        <input type="number" step="any" name="price" id="price" value={price} onChange={(e) => setPrice(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="image">
                            Image
                        </label>
                        <input type="text" name="image" id="image" value={image} onChange={(e) => setImage(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="brand">
                            Brand
                        </label>
                        <input type="text" name="brand" id="brand" value={brand} onChange={(e) => setBrand(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="tag">
                            Tag ID
                        </label>
                        <input type="number" name="tag" id="tag" value={tag_id} onChange={(e) => setTag_id(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="cis">
                            Count in stock
                        </label>
                        <input type="number" name="cis" id="cis" value={count_in_stock} onChange={(e) => setCountinstock(e.target.value)}/>
                    </li>
                    <li>
                        <label htmlFor="description">
                            Description
                        </label>
                        <textarea name="description" id="description" value={description} onChange={(e) => setDescription(e.target.value)}/>
                    </li>
                   
                    <li>
                        <button type="submit" className="button primary">{id ?  "Update Product" : "Create Product"}</button>
                    </li>    
                    <li>
                        <button type="button" onClick={() =>  setCreateProductPop(false)} className="button secondary">Close</button>
                    </li>   
                </ul>
            </form>
        </div>)}
            
            <div className="product-list">
                <table>
                    <thead>
                        <tr> 
                            <th>
                                Name
                            </th>
                            <th>
                                Price
                            </th>
                            <th>
                                Image
                            </th>
                            <th>
                                Category
                            </th>
                            <th>
                                Count in Stock
                            </th>
                            <th>
                                Description
                            </th>
                            <th>
                                Brand
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        {currentPosts.map(product => (
                            <tr key={product.id}>
                            <td>
                                {product.name}
                            </td>
                            <td>
                                 {product.price}
                            </td>
                            <td>
                                 {product.image}
                            </td>
                            <td>
                                 {product.brand}
                            </td>
                            <td>
                                 {product.count_in_stock}
                            </td>
                            <td>
                                 {product.tag_id}
                            </td>
                            <td>
                               {product.description}
                            </td>
                            <th>
                                <button onClick={() => popCreateMenu(product)}> Edit</button>
                                <button> Delete</button>

                            </th>
                        </tr>
                        ))}
                      
                    
                    </tbody> 
                </table>
                <CRUDPagination postsPerPage={postsPerPage} totalPosts={products.length} paginate={paginate} />
            </div>
        </div>
        
        
    );
}

export default CRUDProducts;