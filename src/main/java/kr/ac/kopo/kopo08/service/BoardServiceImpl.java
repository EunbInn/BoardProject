package kr.ac.kopo.kopo08.service;

import java.util.List;

import kr.ac.kopo.kopo08.dao.BoardDao;
import kr.ac.kopo.kopo08.dao.BoardDaoImpl;
import kr.ac.kopo.kopo08.dao.BoardItemDao;
import kr.ac.kopo.kopo08.dao.BoardItemDaoImpl;
import kr.ac.kopo.kopo08.domain.Board;
import kr.ac.kopo.kopo08.domain.BoardItem;

public class BoardServiceImpl implements BoardService{
	private static BoardServiceImpl instance = new BoardServiceImpl(); 
	BoardDao boardDao = BoardDaoImpl.getInstance();
	BoardItemDao commentDao = BoardItemDaoImpl.getInstance();

	private BoardServiceImpl() {
	}
	
	public static BoardServiceImpl getInstance() {
		return instance;
	}
	
	@Override
	public void create(Board board) {
		boardDao.create(board);
	}

	@Override
	public List<Board> selectAll() {
		List<Board> boardList = boardDao.selectAll();
		
		if (boardList.size() != 0) {
			for (int i = 0; i < boardList.size(); i++) {
				Board board = boardList.get(i);
				List<BoardItem> commentList = commentDao.selectAll(board.getId());
				board.setBoardItem(commentList);
			}
		}
		
		return boardList;
	}

	@Override
	public Board selectOne(int id) {
		Board board = boardDao.selectOne(id);
		List<BoardItem> commentList = commentDao.selectAll(board.getId());
		board.setBoardItem(commentList);
		return board;
	}

	@Override
	public void update(Board board) {
		boardDao.update(board);
	}

	@Override
	public void delete(Board board) {
		boardDao.delete(board);
	}

	@Override
	public int getNewID() {
		List<Board> boardList = boardDao.selectAll();
		int newID = 0;
		Board board = boardList.get(0);
		newID = board.getId();
		
		return newID;
	}

}
