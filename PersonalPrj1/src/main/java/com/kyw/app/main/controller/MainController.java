package com.kyw.app.main.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("/main")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/Example")
	public String example() {
		return "Example";
	}
	
	@RequestMapping("/Example2")
	public String example2() {
		return "Example2";
	}

}
