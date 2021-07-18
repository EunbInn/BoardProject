package kr.ac.kopo.kopo08.service;

import java.util.List;

import kr.ac.kopo.kopo08.domain.Board;

public interface BoardService {
	void create(Board board);
	List<Board> selectAll();
	Board selectOne(int id);
	void update(Board board);
	void delete(Board board);
	int getNewID();
}
