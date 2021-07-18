package kr.ac.kopo.kopo08.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.kopo08.domain.Board;
import kr.ac.kopo.kopo08.domain.BoardItem;

public class BoardItemDaoImpl implements BoardItemDao {
	private static BoardItemDaoImpl instance = new BoardItemDaoImpl();
	
	private BoardItemDaoImpl() {}
	
	public static BoardItemDaoImpl getInstance() {
		return instance;
	}

	@Override
	public void create(BoardItem boardItem) {
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			if (boardItem.getParent() == null) {
				query = String.format("insert into boardItem(title, writer, date, content, boardID) values('%s', '%s', now(), '%s', %d);"
										, boardItem.getTitle(), boardItem.getWriter(), boardItem.getContent(), boardItem.getBoardId());
				stmt.execute(query);
			} else {
				query = String.format("insert into boardItem(writer, date, content, parent) values('%s', now(), '%s', %d);"
						, boardItem.getWriter(), boardItem.getContent(), boardItem.getParent().getId());
				stmt.execute(query);
			}
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
	}

	@Override
	//commentList
	public List<BoardItem> selectAll(int id) {
		List<BoardItem> retAll = new ArrayList<BoardItem>();
		BoardItem comments;
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			ResultSet rs = null;
			
			query = String.format("select * from boardItem where boardID=%d order by id desc;", id);
			rs =stmt.executeQuery(query);
			while (rs.next()) {
				comments = new BoardItem(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
				retAll.add(comments);
			}
			
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
		
		return retAll;
	}

	@Override
	//get one content
	public BoardItem selectOne(int id) {
		List<BoardItem> comments = new ArrayList<BoardItem>();
		BoardItem boardItem = null;
		BoardItem comment = null;
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			ResultSet rs = null;
			
			query = String.format("select * from boardItem where id=%d or parent=%d order by id desc;", id, id);
			rs =stmt.executeQuery(query);
			while (rs.next()) {
				if (rs.getString(7) != null) {
					comment = new BoardItem(rs.getInt(1), rs.getString(3), rs.getString(4), rs.getString(5));
					comments.add(comment);
				} else {
					boardItem = new BoardItem(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
				}
			}
			boardItem.setComments(comments);
			
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
		
		return boardItem;
	}

	@Override
	public void update(BoardItem boardItem) {
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			query = String.format("update boardItem set title='%s', content='%s' where id=%d;", 
									boardItem.getTitle(), boardItem.getContent(), boardItem.getId());
			
			stmt.executeUpdate(query);
			
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
	}

	@Override
	public void delete(BoardItem boardItem) {
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			query = String.format("delete from boardItem where id=%d or parent=%d;", 
									boardItem.getId(), boardItem.getId());
			stmt.execute(query);

			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
	}

	@Override
	public List<BoardItem> selectAll() {
		List<BoardItem> retAll = new ArrayList<BoardItem>();
		BoardItem comments;
		Connection con = null;
		Statement stmt = null;
		String query = "";
		try {
			Class.forName("com.mysql.cj.jdbc.Driver"); 
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/myDB", ConstValue.id, ConstValue.pw);
			stmt = con.createStatement();
			ResultSet rs = null;
			
			query = String.format("select * from boardItem order by id desc;");
			rs =stmt.executeQuery(query);
			while (rs.next()) {
				comments = new BoardItem(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5), rs.getInt(6));
				retAll.add(comments);
			}
			
			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
		
		return retAll;
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
			query = String.format("select id from boarditem where boardID=%d;", board.getId());
			ResultSet rs = stmt.executeQuery(query);
			List<Integer> id = new ArrayList<Integer>();
			while (rs.next()) {
				id.add(rs.getInt(1));
			}
			
			if (id.size() != 0) {
				for (int bid : id) {
					query = String.format("delete from boarditem where parent=%d;", bid);
					stmt.execute(query);
				}
			}

			query = String.format("delete from boarditem where boardID=%d;", board.getId());
			stmt.execute(query);

			

			rs.close();
			stmt.close();
			con.close();
		} catch (Exception e) {
			String err = e.getMessage();
			System.out.println(err);
		} finally {}
	}

}
