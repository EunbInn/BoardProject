package kr.ac.kopo.kopo08.dao;

import java.util.List;

import kr.ac.kopo.kopo08.domain.Board;
import kr.ac.kopo.kopo08.domain.BoardItem;

public interface BoardItemDao {
	void create(BoardItem boardItem);
	List<BoardItem> selectAll(int id); 
	BoardItem selectOne(int id); //content
	void update(BoardItem boardItem);
	void delete(BoardItem boardItem);
	void delete(Board board);
	List<BoardItem> selectAll();
}
