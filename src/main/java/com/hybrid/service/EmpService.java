package com.hybrid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hybrid.mapper.EmpMapper;
import com.hybrid.model.Emp;


@Service
public class EmpService {
	
	@Autowired				// spring Factory에 자동 주입
	EmpMapper empMapper;

	@Transactional			// 실행시 자동 처리 commint을 해줌
	public List<Emp> getList(){
		List<Emp> emps = empMapper.seletAll();
		return emps;
	}
	
	@Transactional
	public Emp getEmp(Integer empno){
		return empMapper.seletByEmpno(empno);
	}
	
	@Transactional
	public void insert(Emp emp){
		empMapper.insert(emp);
	}
	
	@Transactional
	public Emp delete(Integer empno){
		
		Emp emp = empMapper.seletByEmpno(empno); // 조회 후
		empMapper.deleteByEmpno(empno); //삭제 수행
		
		return emp; //지운 정보를 리턴
	}
	
}
