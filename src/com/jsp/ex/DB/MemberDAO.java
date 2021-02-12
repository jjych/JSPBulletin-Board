package com.jsp.ex.DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MemberDAO() {
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
	
	public int login(String userID,String userPassword) {
		String SQL = "select m_pw from member where m_id = ?";
		try {
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; // 로그인 성공
				}
				else {
					return 0; //비밀번호 불일치
				}
			}
			return -1; // 아이디가 있음
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -2;  // 데이터베이스 오류
	}
	
	public int join(MemberDTO user) {
		String query = "insert into member values (?,?,?,?)";
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserEmail());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;  // 데이터베이스 오류
	}
}
