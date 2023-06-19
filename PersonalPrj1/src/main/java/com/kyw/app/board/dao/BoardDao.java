package com.kyw.app.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kyw.app.board.vo.BoardVo;
import com.kyw.app.common.file.FileVo;
import com.kyw.app.common.page.PageVo;


@Repository
public class BoardDao {

	
	//목록 조회
	public List<BoardVo> getBoardList(SqlSessionTemplate sst, PageVo pv, Map<String, String> searchMap) {
		int limit = pv.getBoardLimit();
		int offset = (pv.getCurrentPage()-1) * limit;
		RowBounds rb = new RowBounds(offset, limit);
		return sst.selectList("board.getBoardList", searchMap, rb);
	}

	//게시글 갯수 조회
	public int getCnt(SqlSessionTemplate sst, Map<String, String> searchMap) {
		return sst.selectOne("board.getCnt" , searchMap);
	}

	public List<Map<String, String>> getCategoryList(SqlSessionTemplate sst) {
		return sst.selectList("board.getCategoryList");
	}

	//작성하기
	public int write(SqlSessionTemplate sst, BoardVo vo) {
		return sst.insert("board.write", vo);
	}

	public int insertAttachment(SqlSessionTemplate sst, List<FileVo> fvoList) {
		return sst.insert("board.insertAttachment", fvoList);
	}

	public int increaseHit(SqlSessionTemplate sst , String no) {
		return sst.update("board.increaseHit" , no);
	}

	public BoardVo getBoard(SqlSessionTemplate sst , String no) {
		return sst.selectOne("board.getBoard" , no);
	}
	
	public List<FileVo> getAttachmentList(SqlSessionTemplate sst, String no) {
		return sst.selectList("board.getAttachmentList" , no);
	}

	public int updateBoard(SqlSessionTemplate sst, BoardVo vo) {
		return sst.update("board.updateBoard", vo);
	}

	public int delete(SqlSessionTemplate sst, BoardVo vo) {
		return sst.update("board.delete", vo);
	}
	
	
	
	//

}
