package kr.ac.kopo.kopo08.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.kopo08.domain.Board;

public class BoardDaoImpl implements BoardDao{
	private static BoardDaoImpl instance = new BoardDaoImpl();
	
	private BoardDaoImpl() {}

	public static BoardDaoImpl getInstance() {
		return instance;
	}
	
	@Override
	public void create(Board board) {
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			query = String.format("insert into board(title) values('%s');"
									, board.getTitle());
			stmt.execute(query);
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
			e.printStackTrace();
		} finally {}
	}

	@Override
	public List<Board> selectAll() {
		List<Board> retAll = new ArrayList<Board>();
		Board board;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			Statement stmt = con.createStatement();
			
			query = "select * from board order by id desc;";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				board = new Board(rs.getInt(1), rs.getString(2));
				retAll.add(board);
			}
			
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
			e.printStackTrace();
		} finally {}
		
		return retAll;
	}

	@Override
	public Board selectOne(int id) {
		Board board = null;
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			ResultSet rs = null;
			
			query = "select * from board where id=" + id +";";
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				board = new Board(rs.getString(2));
			}
			
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
		return board;
	}

	@Override
	public void update(Board board) {
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			
			query = String.format("update board set title='%s' where id=%d;", 
									board.getTitle(), board.getId());
			stmt.executeUpdate(query);
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
	}

	@Override
	public void delete(Board board) {
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			
			query = String.format("delete from board where id=%d;", board.getId());
			stmt.execute(query);
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
	}

}
