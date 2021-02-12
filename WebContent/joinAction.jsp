<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jsp.ex.DB.MemberDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id ="user" class="com.jsp.ex.DB.MemberDTO" scope="page" />
<jsp:setProperty name ="user" property="userID" />
<jsp:setProperty name ="user" property="userPassword" />
<jsp:setProperty name ="user" property="userName"/>
<jsp:setProperty name ="user" property="userEmail"/>
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
      if(userID != null){
 	     PrintWriter script = response.getWriter();
 	     script.println("<script>");
 	     script.println("alert('이미 로그인이 되어 있습니다.')");
 	     script.println("location.href = 'main.jsp'");
 	     script.println("</script>");
      } 
      if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null
    		  || user.getUserEmail() == null){
    	  PrintWriter script = response.getWriter();
    	  script.println("<script>");
    	  script.println("alert('빈칸없이 입력해주세요.')");
    	  script.println("history.back()");
    	  script.println("</script>");
      }
      else{
    	  MemberDAO mDAO = new MemberDAO();
          int result = mDAO.join(user);
    	  if(result == -1){
    		  PrintWriter script = response.getWriter();
        	  script.println("<script>");
        	  script.println("alert('이미 존재하는 아이디입니다.')");
        	  script.println("history.back()");
        	  script.println("</script>");
          }
          else{
        	  session.setAttribute("userID",user.getUserID());
        	  PrintWriter script = response.getWriter();
        	  script.println("<script>");
        	  script.println("location.href = 'main.jsp'");
        	  script.println("</script>");
          }
      }
   %>
</body>
</html>