<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

  <meta charset="UTF-8">
  <title>JOIN/LOGIN</title>
  <style type="text/css">
  
 
  </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>


  <div class="section">
    <div class="container">
      <div class="row full-height justify-content-center">
        <div class="col-12 text-center align-self-center py-5">
          <div class="section pb-5 pt-5 pt-sm-2 text-center">
            <h6 class="mb-0 pb-3" style="color : white"><span>Log In </span><span>Sign Up</span></h6>
                  <input class="checkbox" type="checkbox" id="reg-log" name="reg-log"/>
                  <label for="reg-log"></label>
            <div class="card-3d-wrap mx-auto">
              <div class="card-3d-wrapper">
                <div class="card-front">
                  <div class="center-wrap">
                    <div class="section text-center">
                      <h4 class="mb-4 pb-3" style="color : white">Log In</h4>
                      
                      	
                      
                      <!-- 로그인 -->
                      <form action="${root}/member/login" method="post">
                      
                      <div class="form-group">
                        <input type="text" name="id" class="form-style" placeholder="Your Id" autocomplete="off">
                        <i class="input-icon uil uil-at"></i>
                      </div>  
                      <div class="form-group mt-2">
                        <input type="password" name="pwd" class="form-style" placeholder="Your Password"  autocomplete="off">
                        <i class="input-icon uil uil-lock-alt"></i>
                      </div>
                        <input type="submit" class="btn mt-4" value="submit">
                      
                      </form>
                      
                      
                      
                      
<!--                                     <p class="mb-0 mt-4 text-center"><a href="#0" class="link">Forgot your password?</a></p>-->                        
						</div>
                      </div>
                    </div>
                    
                    
                    
                <div class="card-back">
                  <div class="center-wrap">
                    <div class="section text-center">
                      <h4 class="mb-4 pb-3" style="color : white">Sign Up</h4>
                      
                      
                      
                      <!-- 회원가입 -->
                      <form action="${root}/member/join" method="POST" enctype="multipart/form-data" onsubmit="return checkValidation();">                   
                      <div class="form-group">
                        <input type="text" name="id" class="form-style" placeholder="Your ID" autocomplete="off">
                        <i class="input-icon uil uil-user"></i>
                      </div>  
                      <div class="form-group mt-2">
                        <input type="password" name="pwd" class="form-style" placeholder="Your Password"autocomplete="off">
                        <i class="input-icon uil uil-lock-alt"></i>
                      </div>
                      <div class="form-group mt-2">
                        <input type="text" name="nick" class="form-style" placeholder="Your NickName" autocomplete="off">
                        <i class="input-icon uil uil-at"></i>
                      </div>  
                      <input type="submit" class="btn mt-4" value="submit">
                      
                      
                      </form>
                      
                      
                      
                      
                      
                      
                      
                     	</div>                                          
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
      </div>
  </div>


</body>
</html>