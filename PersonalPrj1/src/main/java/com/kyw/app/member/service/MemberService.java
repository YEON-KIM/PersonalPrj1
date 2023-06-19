package com.kyw.app.member.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kyw.app.member.dao.MemberDao;
import com.kyw.app.member.vo.MemberVo;

@Service
@Transactional
public class MemberService {
	
	private final SqlSessionTemplate sst;
	private final MemberDao dao;
	
	

	public MemberService(SqlSessionTemplate sst, MemberDao dao) {
		this.sst = sst;
		this.dao = dao;
	}



	public MemberVo login(MemberVo vo) {
		return dao.login(sst, vo);
	}



	public int join(MemberVo vo) {
		return dao.join(sst, vo);
	}

}
