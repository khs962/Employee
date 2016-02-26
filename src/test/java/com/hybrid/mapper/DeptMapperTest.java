package com.hybrid.mapper;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.context.support.GenericXmlApplicationContext;

import com.hybrid.model.Dept;

public class DeptMapperTest {
	public static void main(String[] args) {
		
		GenericXmlApplicationContext ctx =null;
		ctx = new GenericXmlApplicationContext("classpath:spring/beans_db.xml");
		
		//SqlSessionTemplate sqlSession = ctx.getBean(SqlSessionTemplate.class);
		SqlSessionTemplate sqlSession = (SqlSessionTemplate) ctx.getBean("sqlSessionTemplate");
		
		DeptMapper deptMapper = sqlSession.getMapper(DeptMapper.class);
		
		List<Dept> depts=  deptMapper.seletAll();
		
		for(Dept d : depts){
			
			System.out.println(d.getDeptno()+" " + d.getDname()+ " " + d.getLoc());
		}
		
		ctx.close();
	}
}
