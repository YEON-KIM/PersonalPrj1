package com.kyw.app.member.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kyw.app.member.vo.MemberVo;

@Repository
public class MemberDao {

	public MemberVo login(SqlSessionTemplate sst, MemberVo vo) {
		return sst.selectOne("member.login", vo);
	}

	public int join(SqlSessionTemplate sst, MemberVo vo) {
		return sst.insert("member.join", vo);
	}

}
