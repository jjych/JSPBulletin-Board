<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jsp.ex.bbs.BoardDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id ="bbs" class="com.jsp.ex.bbs.BoardDTO" scope="page" />
<jsp:setProperty name ="bbs" property="title" />
<jsp:setProperty name ="bbs" property="content" />
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
      if(userID == null){
 	     PrintWriter script = response.getWriter();
 	     script.println("<script>");
 	     script.println("alert('로그인을 하세요.')");
 	     script.println("location.href = 'login.jsp'");
 	     script.println("</script>");
      } else{
    	  if(bbs.getTitle() == null || bbs.getContent() == null){
        	  PrintWriter script = response.getWriter();
        	  script.println("<script>");
        	  script.println("alert('빈칸없이 입력해주세요.')");
        	  script.println("history.back()");
        	  script.println("</script>");
          }
          else{
        	  BoardDAO bDAO = new BoardDAO();
              int result = bDAO.write(bbs.getTitle(), userID, bbs.getContent());
        	  if(result == -1){
        		  PrintWriter script = response.getWriter();
            	  script.println("<script>");
            	  script.println("alert('글쓰기에 실패했습니다..')");
            	  script.println("history.back()");
            	  script.println("</script>");
              }
              else{
            	  PrintWriter script = response.getWriter();
            	  script.println("<script>");
            	  script.println("location.href = 'bbs.jsp'");
            	  script.println("</script>");
               }
            }
        }
   %>
</body>
</html>