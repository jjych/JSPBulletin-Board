package com.jsp.ex.bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BoardDAO {
	private Connection con;
	private ResultSet rs;
	
	public BoardDAO() {
		try {
			String url = "jdbc:mariadb://localhost:3307/lecture";
			String did = "root";
			String dpw = "1234";
			Class.forName("org.mariadb.jdbc.Driver");
			con = DriverManager.getConnection(url,did,dpw);
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() {
		String query = "select now()";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";  // 데이터베이스오류
	}
	
	public int getNext() {
		String query = "select bId from mvc_board order by bId DESC";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1; // 첫번째 게시물인 경우 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;  // 데이터베이스오류
	}
	
	public int write(String Title, String userID, String Content) {
		String query = "insert into mvc_board values (?,?,?,?,?,?,?,?,?)";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, Title);
			pstmt.setString(4, Content);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, getNext());
			pstmt.setInt(7, getNext());
			pstmt.setInt(8, getNext());
			pstmt.setInt(9, 1);
			
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;  // 데이터베이스오류
	}
	
	public ArrayList<BoardDTO> getList(int pageNumber){
		String query = "select * from mvc_board where bId < ? and bIndent = 1 order by bId desc limit 10";
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				BoardDTO bbs = new BoardDTO();
				bbs.setId(rs.getInt(1));
				bbs.setName(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setContent(rs.getString(4));
				bbs.setDate(rs.getDate(5));
				bbs.setHit(rs.getInt(6));
				bbs.setGroup(rs.getInt(7));
				bbs.setStep(rs.getInt(8));
				bbs.setIndent(rs.getInt(9));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;  
	}
	
	public boolean nextPage(int pageNumber) {
		String query = "select * from mvc_board where bId < ? and bIndent = 1";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public BoardDTO getBoardDTO(int bbsID) {
		String query = "select * from mvc_board where bId = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				BoardDTO bbs = new BoardDTO();
				bbs.setId(rs.getInt(1));
				bbs.setName(rs.getString(2));
				bbs.setTitle(rs.getString(3));
				bbs.setContent(rs.getString(4));
				bbs.setDate(rs.getDate(5));
				bbs.setHit(rs.getInt(6));
				bbs.setGroup(rs.getInt(7));
				bbs.setStep(rs.getInt(8));
				bbs.setIndent(rs.getInt(9));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	// 수정
	public int update(int bbsID, String Title, String Content) {
		String query = "update mvc_board set bTitle = ? , bContent = ? where bId = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setString(1, Title);
			pstmt.setString(2, Content);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;  // 데이터베이스오류
	}
	
	// 삭제
	public int delete(int bbsID) {
		String query = "update mvc_board set bIndent = 0 where bId = ?";
		try {
			PreparedStatement pstmt = con.prepareStatement(query);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;  // 데이터베이스오류
	}
}
