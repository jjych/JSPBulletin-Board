<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="com.jsp.ex.DB.MemberDTO" %>
<%@ page import ="com.jsp.ex.DB.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name = "viewport" content ="width=device-width" , inital-scale ="1">
<link rel ="stylesheet" href ="css/bootstrap.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
    <%
        String userID = null;
        if(session.getAttribute("userID") != null){
        	userID = (String)session.getAttribute("userID");
        }
    %>
    <nav class ="navbar navbar-default">
        <div class ="navbar-header">
           <button type ="button" class ="navbar-toggle collapsed"
               data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
               aria-expanded="false">
               <span class = "icon-bar"></span>
               <span class = "icon-bar"></span>
               <span class = "icon-bar"></span>    
           </button>
           <a class = "navbar-brand" href="main.jsp">지옥 맛 사이트</a>
        </div>
        <div class = "collapse navbar-collapse" id ="bs-example-navbar-collapse-1">
            <ul class ="nav navbar-nav">
                 <li><a href ="main.jsp">메인</a></li>
                 <li><a href ="bbs.jsp">게시판</a></li>
            </ul>
            <ul class ="nav navbar-nav navbar-right">
                 <li class ="dropdown">
                     <a href="#" class ="dropdown-toggle"
                           data-toggle="dropdown" role = "button" aria-haspopup="true"
                           aria-expanded="false">회원관리<span class="caret"></span></a>
                     <ul class ="dropdown-menu">
                         <li class = "active"><a href="modify.jsp">회원정보수정</a></li>
                         <li><a href="logoutAction.jsp">로그아웃</a></li>
                     </ul>
                 </li>
            </ul>
        </div>
    </nav>
    <div class = "container">
       <div class = "col-lg-4"></div>
       <div class = "col-lg-4">
            <div class ="jumbotron" style ="padding-top: 20px;">
                 <form method ="post" action = "modifyAction.jsp">
                     <h3 style="text-align : center;">지옥 회원정보 수정</h3>
                     <div class ="form-group">
                                            회원아이디 : <%=userID %>
                     </div>
                     <div class ="form-group">
                         <input type ="password" class="form-control" placeholder="비밀번호" name="userPassword" maxlength="20">
                     </div>
                     <div class ="form-group">
                         <input type ="text" class="form-control" placeholder="이름" name="userName" maxlength="20">
                     </div>
                     <div class ="form-group">
                         <input type ="email" class="form-control" placeholder="이메일" name="userEmail" maxlength="20">
                     </div>
                     <input type ="submit" class ="btn btn-primary form-control" value="수정완료"> 
                 </form>
            </div>
       </div>
    <script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
    <script src = "js/bootstrap.js"></script>
</body>
</html>