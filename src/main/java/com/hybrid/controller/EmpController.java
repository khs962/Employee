package com.hybrid.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hybrid.model.Emp;
import com.hybrid.model.Mgr;
import com.hybrid.service.EmpService;

@Controller
public class EmpController {
	
	static Log log = LogFactory.getLog(EmpController.class);
	
	@Autowired
	EmpService empService;

	@RequestMapping(value="/emp/list",method=RequestMethod.GET)
	@ResponseBody // 이게 없으면 mvc view-resolver가 작동한다. 
	public List<Emp> getList() {
		
		return empService.getList();		
	}
	
	@RequestMapping(value="/emp/mgrs")
	@ResponseBody // 이게 없으면 mvc view-resolver가 작동한다. 
	public List<Mgr> getMgrs() {
	
		return empService.getMgrs();		
	}
	
	@RequestMapping(value="/emp", method=RequestMethod.GET)
	@ResponseBody
	public Emp getEmp(Integer empno) {
		log.info("getEmp() empno=" + empno);
		
		Emp emp = empService.getEmp(empno);
		
		// 테스트 - 가사의 DB를 셋팅해 본 방법
		// 원래는 두테이블을 조인해서 가져와서 설정해야 함
		// mybatis를 이용해야 됨
		//Dept dept = new Dept();
		//dept.setDeptno(emp.getDeptno());
		//dept.setDname("총무부");
		
		//emp.setDept(dept);
		
		
		return emp;
	}
	
	@RequestMapping(value="/emp", method=RequestMethod.POST)
	@ResponseBody
	public Map<String,Object> postEmp(@RequestBody Emp emp) { //@RequestBody를 안하면 json이 안넘어옴
		log.info("emp = " + emp); //json변환해서 한번에 인포정보를 볼수 있다.
//		log.info("ename = " + emp.getEname());
//		log.info("job = " + emp.getJob());
//		log.info("mgr = " + emp.getMgr());
//		log.info("hiredate = " + emp.getHiredate());
		
		Map<String,Object> response = new HashMap<>();
			
		response.put("success", true);
		response.put("message", "직원 추가 성공");
		
		try{
			empService.insert(emp);
		}catch(DuplicateKeyException ex){
			response.put("success", false);
			response.put("message","직원 번호 중복 에러 입니다.");
		}catch(RuntimeException ex){
			log.error("emp 추가 에러",ex);
			response.put("success", false);
			response.put("message","직원추가 에러입니다.");
		}
		return response;
	}
	
	
//	@RequestMapping(value="/emp", method=RequestMethod.POST)
//	@ResponseBody
//	public Map<String,Object> postEmp(@RequestBody Emp emp) {
//		log.info("empno = " + emp.getEmpno());
//		log.info("ename = " + emp.getEname());
//		log.info("job = " + emp.getJob());
//		log.info("mgr = " + emp.getMgr());
//		log.info("hiredate = " + emp.getHiredate());
//		log.info("sal = " + emp.getSal());
//		log.info("comm = " + emp.getComm());
//		log.info("deptno = " + emp.getDeptno());
//		
//		Map<String,Object> result = new HashMap<>();
//		
//		result.put("success", true);
//		result.put("message","사원 추가 성공");
//		
//		try{
//			empService.insert(emp);
//		}catch(DuplicateKeyException ex){
//			log.info(ex.getMessage());
//			result.put("success", false);
//			result.put("message", "사원 입력 중복입니다.");
//		}
//		return result;
//	}
	
	@RequestMapping(value="/emp", method=RequestMethod.PUT)
	@ResponseBody
	public Map<String,Object> putEmp(@RequestBody Emp emp) {
		log.info("empno = " + emp.getEmpno());
		log.info("ename = " + emp.getEname());
		log.info("job = " + emp.getJob());
		log.info("mgr = " + emp.getMgr());
		log.info("hiredate = " + emp.getHiredate());
		log.info("sal = " + emp.getSal());
		log.info("comm = " + emp.getComm());
		log.info("deptno = " + emp.getDeptno());
		
		Map<String,Object> result = new HashMap<>();
		
		result.put("success", true);
		result.put("message","사원 수정 성공");
		
		try{
			empService.update(emp);
		}catch(DuplicateKeyException ex){
			log.info(ex.getMessage());
			result.put("success", false);
			result.put("message", "사원 수정 오류 입니다.");
		}
		return result;
	}
	
	@RequestMapping(value="/emp", method=RequestMethod.DELETE)
	@ResponseBody
	public Map<String,Object> deleteEmp(Integer empno) {
		log.info("empno = " + empno );
		
		Map<String,Object> result = new HashMap<>();
		
		try{
			empService.delete(empno);
		}catch(RuntimeException ex){
			log.info("error...", ex);
			log.info(ex.getMessage());
			result.put("success", false);
			result.put("message", "직원삭제 실패");
		}
		
		return result;
	}

}
