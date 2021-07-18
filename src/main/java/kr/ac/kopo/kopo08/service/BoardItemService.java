package kr.ac.kopo.kopo08.service;

import java.util.List;

import kr.ac.kopo.kopo08.domain.Board;
import kr.ac.kopo.kopo08.domain.BoardItem;

public interface BoardItemService {
	void create(BoardItem comment);
	List<BoardItem> selectAll(int id);
	BoardItem selectOne(int id);
	void update(BoardItem comment);
	void delete(BoardItem comment);
	void delete(Board board);
	int getNewID();
	List<BoardItem> selectChoice(int id, String find, String findType);
}
