package com.kyw.app.board.service;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kyw.app.board.dao.BoardDao;
import com.kyw.app.board.vo.BoardVo;
import com.kyw.app.common.file.FileVo;
import com.kyw.app.common.page.PageVo;

@Service
public class BoardService {
	
	private final BoardDao dao;
	private final SqlSessionTemplate sst;
	
	
	
	@Autowired
	public BoardService(BoardDao dao, SqlSessionTemplate sst) {
		this.dao = dao;
		this.sst = sst;
	}

	//목록 조회
	public List<BoardVo> getBoardList(PageVo pv, Map<String, String> searchMap) {
		return dao.getBoardList(sst, pv, searchMap);
	}

	//게시글 갯수 조회
	public int getCnt(Map<String, String> searchMap) {
		return dao.getCnt(sst, searchMap);
	}

	//카테고리 리스트
	public List<Map<String, String>> getCategoryList() {
		return dao.getCategoryList(sst);
	}

	public int write(BoardVo vo, List<FileVo> fvoList) {
		int boardResult = dao.write(sst, vo);
		int attResult = 1;
		if(fvoList.size() > 0) {
			attResult = dao.insertAttachment(sst, fvoList);
			
		}
		return boardResult * attResult;
		
	}

	public BoardVo getBoard(String no) throws Exception {
		int result = dao.increaseHit(sst, no);
		if (result != 1) {
			throw new Exception();
		}
		BoardVo bvo = dao.getBoard(sst, no);
		List<FileVo> fileList = dao.getAttachmentList(sst, no);
		bvo.setAttList(fileList);
		return bvo;
	}

	public int updateBoard(BoardVo vo) {
		return dao.updateBoard(sst, vo);
	}

	public int delete(BoardVo vo) {
		return dao.delete(sst, vo);
	}



}
