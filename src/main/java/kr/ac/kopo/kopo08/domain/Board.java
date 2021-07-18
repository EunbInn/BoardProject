package kr.ac.kopo.kopo08.domain;

import java.util.List;

public class Board {
	private int id;
	private String title;
	List<BoardItem> boardItem;

	public Board() {
	}

	public Board(int id, String title) {
		this.id = id;
		this.title = title;
	}

	public Board(String title) {
		this.title = title;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public List<BoardItem> getBoardItem() {
		return boardItem;
	}

	public void setBoardItem(List<BoardItem> boardItem) {
		this.boardItem = boardItem;
	}

}
