package com.hybrid.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hybrid.model.Dept;
import com.hybrid.service.DeptService;

@Controller
public class DeptController {
	
	static Log log = LogFactory.getLog(DeptController.class);
	
	@Autowired
	DeptService deptService;
	
	
	@RequestMapping(value="/dept/list",method=RequestMethod.GET) //ajax에서 list.jsp를 가져온 것
	@ResponseBody  // 이게 없으면 mvc view-resolver가 작동한다. 
	public List<Dept> getList(){

		return deptService.getList();
	}
	
	@RequestMapping(value="/dept",method=RequestMethod.GET) //조회하는 부분 select 
	@ResponseBody  // 이게 없으면 mvc view-resolver가 작동한다. 
	public Dept getDept(Integer deptno){
		log.info("getDept() deptno=" +deptno);
		
		return deptService.getDept(deptno);
	}
	
	@RequestMapping(value="/dept",method=RequestMethod.POST) // 삽입하는 부분 insert
	@ResponseBody  // 이게 없으면 mvc view-resolver가 작동한다. 
	public Map<String,Object> postDept(@RequestBody Dept dept){ //Dept객체를 json변환된것을 자바의 dept 객체로 변환
		log.info("deptno =" + dept.getDeptno());
		log.info("dname =" + dept.getDname());
		log.info("loc =" + dept.getLoc());
		
		Map<String,Object> response = new HashMap<>();
		
		response.put("success", true);
		response.put("message",	"부서 추가 성공");
		
		try{
			deptService.insert(dept);
		}catch(DuplicateKeyException ex){
			
			log.info(ex.getMessage());
			response.put("success", false);
			response.put("message", "부서코드 중복입니다. 다시입력하세요");
		
		}
	
		
		return response;
	}
	
	
	// 데이터 수정부분 - put
	@RequestMapping(value="/dept",method=RequestMethod.PUT)
	@ResponseBody  // 이게 없으면 mvc view-resolver가 작동한다. 
	public Map<String,Object> putDept(@RequestBody Dept dept){
		log.info("deptno = " + dept.getDeptno());
		log.info("dname = " + dept.getDname());
		log.info("loc = " + dept.getLoc());
		
		
		Map<String,Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message",	"부서 수정 성공");
		
		try{
			deptService.update(dept);
		}catch(RuntimeException ex){
			
			log.info(ex.getMessage());
			response.put("success", false);
			response.put("message", "부서수정 에러! 다시 입력하세요");
		
		}
		
		return response;
	}

	@RequestMapping(value="/dept",method=RequestMethod.DELETE)
	@ResponseBody  // 이게 없으면 mvc view-resolver가 작동한다. 
	public Map<String,Object> deleteDept(Integer deptno){
		log.info("deptno =" + deptno);
		
		Map<String,Object> response = new HashMap<>();
		response.put("success", true);
		response.put("message",	"부서 삭제 성공");
		
		try{
			deptService.delete(deptno);
		}catch(DataIntegrityViolationException ex){
			response.put("success", false);
			response.put("message", "직원이 있는 부서는 삭제할 수 없습니다.");
		}catch(RuntimeException ex){
			log.info("error...",ex);
			log.info(ex.getMessage());
			response.put("success", false);
			response.put("message", "부서 삭제 에러! 다시 입력하세요");
		}
		
		
		return response;
	}
	
//	@RequestMapping(value="/dept/listview",method=RequestMethod.GET)
//	public String getListView(){
//		log.info("getListView().....");
//		
//		return "dept/list";
//	} 
	// rest방식 
}
