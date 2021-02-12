<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.jsp.ex.bbs.BoardDAO" %>
<%@ page import="com.jsp.ex.bbs.BoardDTO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
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
      } 
      int bbsID = 0;
      if(request.getParameter("bbsID") != null){
      	bbsID = Integer.parseInt(request.getParameter("bbsID"));
      }
      if(bbsID == 0){
      	 PrintWriter script = response.getWriter();
  	     script.println("<script>");
  	     script.println("alert('유효하지 않은 글입니다.')");
  	     script.println("location.href = 'bbs.jsp'");
  	     script.println("</script>");
      }
      BoardDTO bbs = new BoardDAO().getBoardDTO(bbsID);
      if(!userID.equals(bbs.getName())){
      	 PrintWriter script = response.getWriter();
  	     script.println("<script>");
  	     script.println("alert('권한이 없습니다.')");
  	     script.println("location.href = 'bbs.jsp'");
  	     script.println("</script>");
      }else{
    	  if(request.getParameter("title") == null || request.getParameter("content") == null
    			  || request.getParameter("title").equals("") || request.getParameter("content").equals("")){
        	  PrintWriter script = response.getWriter();
        	  script.println("<script>");
        	  script.println("alert('입력이 안 된 사항이 있습니다.')");
        	  script.println("history.back()");
        	  script.println("</script>");
          }
          else{
        	  BoardDAO bDAO = new BoardDAO();
              int result = bDAO.update(bbsID, request.getParameter("title"), request.getParameter("content"));
        	  if(result == -1){
        		  PrintWriter script = response.getWriter();
            	  script.println("<script>");
            	  script.println("alert('글 수정에 실패했습니다.')");
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