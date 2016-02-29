package com.hybrid.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hybrid.mapper.DeptMapper;
import com.hybrid.model.Dept;

@Service
public class DeptService {
	
	@Autowired				// spring Factory에 자동 주입
	DeptMapper deptMapper;

	@Transactional			// 실행시 자동 처리 commint을 해줌
	public List<Dept> getList(){
		List<Dept> depts = deptMapper.seletAll();
		return depts;
	}
	
	@Transactional
	public Dept getDept(Integer deptno){
		return deptMapper.seletByDeptno(deptno);
	}
	
	@Transactional
	public void insert(Dept dept){
		deptMapper.insert(dept);
	}
	
	@Transactional
	public Dept delete(Integer deptno){
		
		Dept dept = deptMapper.seletByDeptno(deptno); // 조회 후
		deptMapper.deleteByDeptno(deptno); //삭제 수행
		
		return dept; //지운 정보를 리턴
	}
	
}
