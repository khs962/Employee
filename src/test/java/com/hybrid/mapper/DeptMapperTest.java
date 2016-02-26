package com.hybrid.mapper;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.hybrid.model.Dept;

public class DeptMapperTest {
	public static void main(String[] args) {
		GenericXmlApplicationContext ctx =null;
		ctx = new GenericXmlApplicationContext("classpath:spring/beans_db.xml");
		
		DeptMapper mapper = ctx.getBean(DeptMapper.class);
		List<Dept> depts =  mapper.seletAll();
		
		for(Dept d : depts){
			
			System.out.println(d.getDeptno()+" " + d.getDname()+ " " + d.getLoc());
		}
		
		ctx.close();
	}
	
	void test1(){
		GenericXmlApplicationContext ctx =null;
		ctx = new GenericXmlApplicationContext("classpath:spring/beans_db.xml");
		
		//SqlSessionTemplate sqlSession = ctx.getBean(SqlSessionTemplate.class);
		SqlSessionTemplate sqlSession = (SqlSessionTemplate) ctx.getBean("sqlSessionTemplate");
		
		DeptMapper deptMapper = sqlSession.getMapper(DeptMapper.class);
		List<Dept> depts1=  deptMapper.seletAll();
		
		/* 위 두줄 대체 List<Dept> depts= sqlSession.selectList("com.hybrid.mapper.DeptMapper.selectAll()");*/
		
		for(Dept d : depts1){
			
			System.out.println(d.getDeptno()+" " + d.getDname()+ " " + d.getLoc());
		}
		
		ctx.close();
	}
}
