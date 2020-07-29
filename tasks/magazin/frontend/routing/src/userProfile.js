import React, { useCallback } from 'react';
import './userProfile.css';
import { useSelector, useDispatch } from 'react-redux';
import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { signup } from './actions/userActions';




function UserProfile() {
  const [edit,setEdit] = React.useState(0);
  const userSignIn = useSelector(state=>state.userSignIn);
  const {userInfo} = userSignIn;
  const dispatch = useDispatch();
  const [name,setName] = useState(userInfo.name);
  const [username,setUsername] = useState(userInfo.username);
  const [email,setEmail] = useState(userInfo.email);
  const [password,setPassword] = useState('');
  var temp = name.split(" ")
  const [firstName,setFirstName] = useState(temp[0])
  const [secondName,setSecondName] = useState(temp[1])

 



  const handleEditClick = () => {
    setEdit(!edit);
  };

  const handleSaveClick = () => {
    var update = 1;
    dispatch(signup(firstName+" "+secondName,username,email,password,update));
    setEdit(!edit);
  };
  useEffect(() => {
    
},[edit]);
  
  return (

  <div class="main-content">
  
    <nav class="navbar navbar-top navbar-expand-md navbar-dark" id="navbar-main">
      <div class="container-fluid">
       <Link to="/">
       <p class="h4 mb-0 text-white text-uppercase d-none d-lg-inline-block" target="_blank">Обратно към сайта</p>
       </Link>
        <ul class="navbar-nav align-items-center d-none d-md-flex">
          <li class="nav-item dropdown">
            <a class="nav-link pr-0" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              <div class="media align-items-center">
                <span class="avatar avatar-sm rounded-circle">
                  <img alt="Image placeholder" src="http://localhost:5000/bookprofilepic.png"></img>
                </span>
                <div class="media-body ml-2 d-none d-lg-block">
                  <span class="mb-0 text-sm  font-weight-bold">{userInfo.name}</span>
                </div>
              </div>
            </a>
            <div class="dropdown-menu dropdown-menu-arrow dropdown-menu-right">
              <div class=" dropdown-header noti-title">
                <h6 class="text-overflow m-0">Добре дошъл!</h6>
              </div>
              <a href="../examples/profile.html" class="dropdown-item">
                <i class="ni ni-single-02"></i>
                <span>Моят профил</span>
              </a>
              <a href="../examples/profile.html" class="dropdown-item">
                <i class="ni ni-settings-gear-65"></i>
                <span>Настройки</span>
              </a>
              <a href="../examples/profile.html" class="dropdown-item">
                <i class="ni ni-calendar-grid-58"></i>
                <span>Дейност</span>
              </a>
              <div class="dropdown-divider"></div>
              <a href="#!" class="dropdown-item">
                <i class="ni ni-user-run"></i>
                <span>Излизане</span>
              </a>
            </div>
          </li>
        </ul>
      </div>
    </nav>
    <div class="header pb-8 pt-5 pt-lg-8 d-flex align-items-center" >
      <span class="mask bg-gradient-default opacity-8"></span>
      <div class="container-fluid d-flex align-items-center">
        <div class="row">
          <div class="col-lg-7 col-md-10">
            <h1 class="display-2 text-white">Здравей, {firstName}!</h1>
            <p class="text-white mt-0 mb-5">Тук можеш да променяш своите лични данни и да контролираш поръчките си.</p>
            {edit?
            <a href="#!" onClick={handleSaveClick} class="btn btn-info">Запази промените</a>
            :   <a href="#!" onClick={handleEditClick} class="btn btn-info">Промени данните</a>
              }
          </div>
        </div>
      </div>
    </div>
    <div class="container-fluid mt--7">
      <div class="row">
        
        <div class="col-xl-8 order-xl-1">
          <div class="card bg-secondary shadow">
            <div class="card-header bg-white border-0">
              <div class="row align-items-center">
                <div class="col-8">
                  <h3 class="mb-0">Моят профил</h3>
                </div>
                <div class="col-4 text-right">
                </div>
               
              </div>
            </div>
            <div class="card-body">
              <form>
                <h6 class="heading-small text-muted mb-4">Информация за потребителя</h6>
                <div class="pl-lg-4">
                  <div class="row">
                    <div class="col-lg-6">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-username">Потребителско име</label>
                        {edit?
                        <input type="text" id="input-username" class="form-control form-control-alternative" placeholder="Username" value={username} onChange={(e) => setUsername(e.target.value)}></input>
                        :  <input disabled type="text" id="input-username" class="form-control form-control-alternative" placeholder="Username" value={username} onChange={(e) => setUsername(e.target.value)}></input>
                    }
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group">
                        <label class="form-control-label" for="input-email">Имейл адрес</label>
                        {edit?
                        <input type="email" id="input-email" class="form-control form-control-alternative" value={email} onChange={(e) => setEmail(e.target.value)}></input>
                        : <input disabled type="email" id="input-email" class="form-control form-control-alternative" value={email} onChange={(e) => setEmail(e.target.value)}></input>

                    }
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-lg-6">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-first-name">Име</label>
                        {edit?
                        <input type="text" id="input-first-name" class="form-control form-control-alternative" placeholder="First name" value={firstName} onChange={(e) => setFirstName(e.target.value)}></input>
                        :  <input disabled type="text" id="input-first-name" class="form-control form-control-alternative" placeholder="First name" value={firstName} onChange={(e) => setFirstName(e.target.value)}></input>
                        }
                      </div>
                    </div>
                    <div class="col-lg-6">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-last-name">Фамилия</label>
                        {edit?
                        <input type="text" id="input-last-name" class="form-control form-control-alternative" placeholder="Last name" value={secondName} onChange={(e) => setSecondName(e.target.value)}></input>
                        :<input disabled type="text" id="input-last-name" class="form-control form-control-alternative" placeholder="Last name" value={secondName} onChange={(e) => setSecondName(e.target.value)}></input>
                        }
                      </div>
                    </div>
                    { edit?
                    
                    <div class="col-lg-6">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-password">Парола</label>
                        <input required type="password" id="input-password" class="form-control form-control-alternative" placeholder="Password" value={password} onChange={(e) => setPassword(e.target.value)}></input>
                      </div>
                    </div>
                    : <div></div>}
                  </div>
                </div>
                <hr class="my-4"></hr>
                <h6 class="heading-small text-muted mb-4">Контакти</h6>
                <div class="pl-lg-4">
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-address">Адрес</label>
                        <input id="input-address" class="form-control form-control-alternative" placeholder="Адрес по местоживеене" value="" type="text"></input>
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="col-lg-4">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-city">Град</label>
                        <input type="text" id="input-city" class="form-control form-control-alternative" placeholder="Град" value=""></input>
                      </div>
                    </div>
                    <div class="col-lg-4">
                      <div class="form-group focused">
                        <label class="form-control-label" for="input-country">Държава</label>
                        <input type="text" id="input-country" class="form-control form-control-alternative" placeholder="Държава" value=""></input>
                      </div>
                    </div>
                    <div class="col-lg-4">
                      <div class="form-group">
                        <label class="form-control-label" for="input-country">Пощенски код</label>
                        <input type="number" id="input-postal-code" class="form-control form-control-alternative" placeholder="Пощенски код"></input>
                      </div>
                    </div>
                  </div>
                </div>
                
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  
    );
  }
  
  
  
  export default UserProfile;