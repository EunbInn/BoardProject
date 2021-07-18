package kr.ac.kopo.kopo08.service;

import java.util.ArrayList;
import java.util.List;

import kr.ac.kopo.kopo08.dao.BoardItemDao;
import kr.ac.kopo.kopo08.dao.BoardItemDaoImpl;
import kr.ac.kopo.kopo08.domain.Board;
import kr.ac.kopo.kopo08.domain.BoardItem;

public class BoardItemServiceImpl implements BoardItemService {
	private static BoardItemServiceImpl instance = new BoardItemServiceImpl();
	BoardItemDao boardItemDao = BoardItemDaoImpl.getInstance();
	
	private BoardItemServiceImpl() {
	}
	
	public static BoardItemServiceImpl getInstance() {
		return instance;
	}
	
	@Override 
	public void create(BoardItem boardItem) {
		boardItemDao.create(boardItem);
	}

	@Override
	public List<BoardItem> selectAll(int id) {
		return boardItemDao.selectAll(id);
	}

	@Override
	public BoardItem selectOne(int id) {
		return boardItemDao.selectOne(id);
	}

	@Override
	public void update(BoardItem boardItem) {
		boardItemDao.update(boardItem);
	}

	@Override
	public void delete(BoardItem boardItem) {
		boardItemDao.delete(boardItem);
	}
	
	@Override
	public int getNewID() {
		List<BoardItem> boardItemList = boardItemDao.selectAll();
		int newID = 0;
		BoardItem boardItem = boardItemList.get(0);
		newID = boardItem.getId();
		
		return newID;
	}
	
	@Override
	public void delete(Board board) {
		boardItemDao.delete(board);
	}

	@Override
	public List<BoardItem> selectChoice(int id, String find, String findType) {
		find = find.trim();
		if (find.equals("")) {
			return boardItemDao.selectAll(id);
		}
		find = find.replaceAll(">", "&gt;");
		find = find.replaceAll("<", "&lt;");
		List<BoardItem> select = new ArrayList<BoardItem>();
		List<BoardItem> itemList = boardItemDao.selectAll(id);
		for (BoardItem boardItem :  itemList) {
			if (boardItem.getTitle().contains(find) && findType.equals("title")) {
				select.add(boardItem);
			} else if (boardItem.getWriter().contains(find) && findType.equals("writer")) {
				select.add(boardItem);
			} else if ((boardItem.getWriter().contains(find) || boardItem.getTitle().contains(find)) && findType.equals("title+writer")) {
				select.add(boardItem);
			}
		}
		return select;
	}

}
