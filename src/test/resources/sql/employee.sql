


select * from EMP
select * from dept


select * from dept
	where deptno = 10
	
-- 조인 emp & dept --
select e.empno  as emp_empno,
       e.ename	as emp_ename,
       e.job	as emp_job,
       e.mgr	as emp_mgr,
       e.hiredate as emp_hiredate,
       e.sal 	as emp_sal,
       e.comm 	as emp_comm,
       e.deptno as emp_deptno,
	   d.deptno as dept_deptno,
	   d.dname 	as dept_dname,
	   d.loc 	as dept_loc
--from   emp e, dept d
--where  e.deptno = d.deptno
--and	   empno = 7369
	from emp e left outer join dept d 
-- 튜플 값이 없는 경우가 있기 때문에 inner는 안된다.
-- inner join은 두 속성값이 일치할 때만 출력된다.
	  on e.deptno = d.deptno
   where empno = 1 
	
-- selectByEmpno
select empno,
       ename,
       job,
       mgr,
       hiredate,
       sal,
       comm,
	   deptno
from   emp 
where	empno = 7654

-- insert


insert into EMP
(
empno,
ename,
job,
mgr,
hiredate,
sal,
comm,
deptno
)
values
(
	0001,
	'홍길동',
	null,
	null,
	null,
	null,
	null,
	null

)

--update

update EMP
   set ename 		= 'xxx',
	   job 			= 'developer',
	   mgr			= 1,
	   hiredate		= null,
	   sal			= null,
	   comm			= null,
	   deptno		= 10
where empno			= 1


select * from EMP

delete from EMP where empno = 1
