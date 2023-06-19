package com.kyw.app.member.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kyw.app.member.service.MemberService;
import com.kyw.app.member.vo.MemberVo;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemberController {
	
	private final MemberService ms;

	@Autowired
	public MemberController(MemberService ms) {
		this.ms = ms;
	}
	
	@PostMapping("member/join")
	public String join(MemberVo vo, Model model, HttpSession session) {
		
		int result = ms.join(vo);
		
		if (result != 1) {
			model.addAttribute("errorMsg", "회원가입 실패");
			return "common/error-page";
		}
		
		session.setAttribute("alertMsg", "회원가입 성공");
		return "redirect:/member/login";
	}

	//로그인 화면
	@GetMapping("member/login")
	public String login() {
		
		return "member/login";
		
	}
	
	//로그인
	@PostMapping("member/login")
	public String login(MemberVo vo, HttpSession session) {
		
		MemberVo loginMember = ms.login(vo);
		
		if (loginMember == null) {
			session.setAttribute("alertMsg", "로그인 실패");
		}
		
		session.setAttribute("loginMember", loginMember);
		return "redirect:/main";
		
	}
	
	//로그아웃
	@RequestMapping("member/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/main";
	}
	

}
