package kr.ac.kopo.kopo08.dao;

import java.util.List;

import kr.ac.kopo.kopo08.domain.Board;

public interface BoardDao {
	void create(Board board);
	List<Board> selectAll();
	Board selectOne(int id);
	void update(Board board);
	void delete(Board board);
}
