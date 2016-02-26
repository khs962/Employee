package com.hybrid.mapper;

import java.util.List;

import com.hybrid.model.Dept;

public interface DeptMapper {
	
	List<Dept> seletAll();
	
	//리스트인지 하나인지는 mybatis가 판단하고,(리턴타입까지)
	// ArrayList는 자동으로 mybatis가 만들어준다.
	//개발자는 정의만해주면 된다. List 인지 인자값을 어떤것을 받을 것인지만 작성
	
	Dept seletByDeptno(int dept); // id 가 메소드처럼 쓰인다.
	
	int insert(Dept dept); 
	int updateByDeptno(Dept dept);
	int deleteByDeptno(int dept);
	
	// 이렇게 불러오기만 하면 자동으로 각 기능이 수행 된다.
	
	
}
