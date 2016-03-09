package com.hybrid.model;

import java.util.Date;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Emp {
	int empno;		//min :1000 ,max :9999
	String ename;	//length = 10
	String job;		//length = 9
	Integer mgr;	// mgr min= 1000 , max=9999
	Date hiredate; 	// java.util.date 
	Integer sal;  	// null 값을 갖을수 있으므로 wrapper 타입  min=0 , max=9999999
	Integer comm; 	// null 값을 갖을수 있으므로 wrapper 타입  min=0 , max=9999999
	Integer deptno;	// null 값을 갖을수 있으므로 wrapper 타입  min=10, max=99
	Dept dept;		// 부서 정보 Dept를 가져와야한다. dept와 emp와 조인 1단계
	
	
	@Override
	public String toString() {
		ObjectMapper mapper = new ObjectMapper();
		
		String value = null;
		try {
			value = mapper.writeValueAsString(this);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}  
		return value;
	}
	
	
	public int getEmpno() {
		return empno;
	}
	public void setEmpno(int empno) {
		this.empno = empno;
	}
	public String getEname() {
		return ename;
	}
	public void setEname(String ename) {
		this.ename = ename;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public Integer getMgr() {
		return mgr;
	}
	public void setMgr(Integer mgr) {
		this.mgr = mgr;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public Integer getSal() {
		return sal;
	}
	public void setSal(Integer sal) {
		this.sal = sal;
	}
	public Integer getComm() {
		return comm;
	}
	public void setComm(Integer comm) {
		this.comm = comm;
	}
	public Integer getDeptno() {
		return deptno;
	}
	public void setDeptno(Integer deptno) {
		this.deptno = deptno;
	}
	public Dept getDept() {
		return dept;
	}
	public void setDept(Dept dept) {
		this.dept = dept;
	}
	
	

}
