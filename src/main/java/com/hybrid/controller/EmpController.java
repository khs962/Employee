package com.hybrid.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hybrid.model.Dept;
import com.hybrid.model.Emp;
import com.hybrid.service.DeptService;
import com.hybrid.service.EmpService;

@Controller
public class EmpController {
	
	static Log log = LogFactory.getLog(EmpController.class);
	
	@Autowired
	EmpService empService;

	@RequestMapping(value="/emp/list")
	@ResponseBody
	public Map<String, Object> getList() {
		Map<String, Object> result = new HashMap<>();
		
		result.put("success", true);
		result.put("message", "조회성공");
		
		result.put("data", empService.getList());
		
		return result;		
	}
	
	@RequestMapping(value="/emp", method=RequestMethod.GET)
	@ResponseBody
	public Emp getEmp(Integer empno) {
		log.info("getEmp() empno=" + empno);
		
		return empService.getEmp(empno);
	}
	
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Emp postEmp(Emp emp) {
		log.info("empno = " + emp.getEmpno());
		
		empService.insert(emp);
		
		return emp;
	}
	
	@RequestMapping(value="/emp", method=RequestMethod.DELETE)
	@ResponseBody
	public Emp deleteEmp(Integer empno) {
		
		return empService.delete(empno);
	}

}
