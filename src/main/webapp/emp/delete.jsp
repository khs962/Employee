<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="employee">	<!-- ng-app는 표준에 맞지 않아 warning이 나므로 앞에 data붙여줌 -->
<head>
<meta charset="UTF-8">
<title>delete.jsp</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- AngularJS library -->
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>

<script type="text/javascript">
var app = angular.module('employee', []);	// angular의 module생성 

//controller 생성, $: angular에서 미리 제공하는 모델객체
app.controller('deleteController', function($scope, $http){	
	// app.controller : angular controller
	// body에서 data-ng-controller="appendController"를 만난 후 이 함수로 들어온다
	// alert("appendController...");
	console.log("deleteController...");
	$scope.empno = ${param.empno};
	$scope.emp = {};
	
	var ajax=$http.get("/Employee/emp?empno="+$scope.empno);
	ajax.then(function(value) {
		$scope.emp = value.data;
		$scope.deleteEmp = function(){
			var ajax = $http.delete("/Employee/emp?empno="+ $scope.emp.empno);
			ajax.then(function(value) {
				if(value.data.success){
					alert(value.data.message);
					location.href="list.jsp";
				}else{
					alert(value.data.message);					
				}
			
			});
		};
			
	
	});
	

	// $scope : map 객체, View와 긴밀히 연동 
	// $http : map, Ajax를 호출하기 위해 미리 만들어놓은 객체
	
	
	/*
	if(value.data.success) 가 true면 list.jsp로 이동
	
							false면 data.message를 alert창으로 띄운다.
	*/
	
	/*
	초기값이 없으면 양방향 바인딩에 의해 알아서 만들어짐
	$scope.data = {
			deptno : 10,
			dname : "총무부",
			loc : "서울"
	}; */
	
	

});


</script>
</head>


<body data-ng-controller="deleteController" class="container-fluid">
<!-- appendController : data 담당 / container-fluid : bootstrap, 여백 없음-->

<!-- 두 문서 간 연결 -->
<a href="list.jsp" class="btn btn-info">부서리스트로...</a>

<div>empno = ${param.empno}</div>



<div class="panel panel-default">
  <div class="panel-heading">부서 정보</div>
  <div class="panel-body">
  	<ul>
  		<li>직원 번호 : {{emp.empno}}</li>
  		<li>이름 : {{emp.ename}}</li>
  		<li>직업 : {{emp.job}}</li>
  		<li>매니저 번호 : {{emp.mgr}}</li>
  		<li>고용일 : {{emp.hiredate | date : 'yyyy년 MM월 dd일'}}</li>
  		<li>연봉 : {{emp.sal}}</li>
  		<li>comm : {{emp.comm}}</li>
  		<li>부서명 : {{emp.deptno}} {{emp.dept.dname}}</li> <!-- 고려할 사항 번호가 아닌 부서명으로 나오게끔-->
  		<!-- 
  		두 테이블을 조인해야하고
  		마이바티스 수동 맵핑처리 해야 한다. -->
  	</ul>
  	<button class="btn btn-primary" data-ng-click="deleteEmp()">직원 삭제</button>
  </div>
  
</div>

<!-- 입력양식, submit page는 ajax로 처리 -->
<!-- validation : 유효한 값만 입력할 수 있도록 입력한 값에 대한 feedback 필요 -->
<!-- novalidate : web browser에서는 validation처리를 하지 않고 angular에서 처리하겠다는 의미 -->
<!-- form name을 dept로 할 경우 form을 dept객체로 인식하므로 form name과
	binding하려는 model이름을 달리해야함  -->
	
	
	
	
<!-- 부서 수정 
update.jsp는 입력이 아닌 기존에 있는 값을 수정해야 되므로
DB에서 기존 입력된 바인딩 값을 불러와야 한다.
-->

</body>
</html>