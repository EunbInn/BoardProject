package kr.ac.kopo.kopo08.domain;

import java.util.List;

public class BoardItem {
	private int id;
	private String title;
	private String writer;
	private String date;
	private String content;
	private int boardId;
	List<BoardItem> comments;
	BoardItem parent;

	public BoardItem() {
	}

	public BoardItem(int id, String title, String writer, String date, String content, int boardId) {
		super();
		this.id = id;
		this.title = title;
		this.writer = writer;
		this.date = date;
		this.content = content;
		this.boardId = boardId;
	}
	
	public BoardItem(int id, String writer, String date, String content) {
		this.id = id;
		this.writer = writer;
		this.date = date;
		this.content = content;
	}
	
	public BoardItem(String title, String writer, String content, int boardId) {
		super();
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.boardId = boardId;
	}
	
	public BoardItem(String writer, String content) {
		this.writer = writer;
		this.content = content;
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

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getBoardId() {
		return boardId;
	}

	public void setBoardId(int boardId) {
		this.boardId = boardId;
	}

	public List<BoardItem> getComments() {
		return comments;
	}

	public void setComments(List<BoardItem> comments) {
		this.comments = comments;
	}

	public BoardItem getParent() {
		return parent;
	}

	public void setParent(BoardItem parent) {
		this.parent = parent;
	}

}
