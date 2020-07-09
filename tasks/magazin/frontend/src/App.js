import React from 'react';
import logo from './logo.svg';
import './App.css';

function App() {
  const openMenu = () => {
    document.querySelector('.sidebar').classList.add('open');
  };
  const closeMenu = () => {
    document.querySelector('.sidebar').classList.remove('open');
  };
 
  return (
    <div className="grid-container">  
        <header className="header">
            <div className="brand">
                <button onClick={openMenu}>&#9776;</button>
                <a href="index.html">Online Shop</a>
            </div>
            <div className="header-links">
                <a href="cart.html">Cart</a>
                <a href="signin.html">Sign In</a>
            </div>
        </header>  
        <aside className="sidebar">
            <h3> Product categories</h3>
            <button className="sidebar-close-button" onClick={closeMenu}>x</button>
            <ul>
                <li>
                    <a href="index.html">Category1</a>
                </li>
                <li>
                    <a href="index.html">Category2</a>
                </li>

            </ul>
        </aside> 
        <main className="main">
            <div className="content">
                <ul className="products">
                  <li>
                  <div className="product">
                            <img className = "product-image" src="/images/cool.jpg" alt="product"></img>
                            <div className="product-name">
                                <a href="product.html">Best Panda</a>
                            </div>
                            <div className="product-brand"> wer </div>
                            <div className="product-price"> 600 лв.</div>
                        </div>

                  
                  </li> 
                  <li>
                  <div className="product">
                            <img className = "product-image" src="/images/cool.jpg" alt="product"></img>
                            <div className="product-name">
                                <a href="product.html">Best Panda</a>
                            </div>
                            <div className="product-brand"> wer </div>
                            <div className="product-price"> 600 лв.</div>
                        </div>

                  
                  </li> 
                  <li>
                  <div className="product">
                            <img className = "product-image" src="/images/cool.jpg" alt="product"></img>
                            <div className="product-name">
                                <a href="product.html">Best Panda</a>
                            </div>
                            <div className="product-brand"> wer </div>
                            <div className="product-price"> 600 лв.</div>
                        </div>

                  
                  </li> 
                  <li>
                  <div className="product">
                            <img className = "product-image" src="/images/cool.jpg" alt="product"></img>
                            <div className="product-name">
                                <a href="product.html">Best Panda</a>
                            </div>
                            <div className="product-brand"> wer </div>
                            <div className="product-price"> 600 лв.</div>
                        </div>

                  
                  </li> 
                  <li>
                  <div className="product">
                            <img className = "product-image" src="/images/cool.jpg" alt="product"></img>
                            <div className="product-name">
                                <a href="product.html">Best Panda</a>
                            </div>
                            <div className="product-brand"> wer </div>
                            <div className="product-price"> 600 лв.</div>
                        </div>

                  
                  </li> 
                </ul>
            </div>
        </main>
        <footer className="footer">   
            All right reserved.
        </footer>
    </div>
  );
}

export default App;
