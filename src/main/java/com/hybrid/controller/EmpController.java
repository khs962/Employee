package com.hybrid.controller;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hybrid.model.Emp;
import com.hybrid.service.EmpService;


@Controller
public class EmpController {
	
	static Log log = LogFactory.getLog(EmpController.class);
	
	@Autowired
	EmpService empService;
	
	
	@RequestMapping(value="/emp/list")
	@ResponseBody
	public List<Emp> getList(){

		return empService.getList();
	}
	
	@RequestMapping(value="/Emp",method=RequestMethod.GET) //조회하는 부분 select 
	@ResponseBody
	public Emp getEmp(Integer empno){
		log.info("getEmp() Empno=" +empno);
		
		return empService.getEmp(empno);
	}
	
	@RequestMapping(value="/Emp",method=RequestMethod.POST) // 삽입하는 부분 insert
	@ResponseBody
	public Emp postEmp(Emp Emp){
		log.info("Empno =" + Emp.getEmpno());
		
	
		empService.insert(Emp);
		
		return Emp;
	}
	
	@RequestMapping(value="/Emp",method=RequestMethod.DELETE)
	@ResponseBody
	public Emp deleteEmp(Integer Empno){
		
		
		return empService.delete(Empno);
	}
	
}
