<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="employee">	<!-- ng-app는 표준에 맞지 않아 warning이 나므로 앞에 data붙여줌 -->
<head>
<meta charset="UTF-8">
<title>detail.jsp</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- AngularJS library -->
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>

<script type="text/javascript">
var app = angular.module('employee', []);	// angular의 module생성 

//controller 생성, $: angular에서 미리 제공하는 모델객체
app.controller('detailController', function($scope, $http){	
	// app.controller : angular controller
	// body에서 data-ng-controller="appendController"를 만난 후 이 함수로 들어온다
	// alert("appendController...");
	console.log("detailController...");
	
	$scope.deptno = ${param.deptno};
	$scope.dept = {};
	//서버에서 param의 deptno 값을 가져와야한다.
	var ajax = $http.get("/Employee/dept?deptno=" + $scope.deptno);
	ajax.then(function(value) {
		$scope.dept = value.data;
	});
	//ajax then 성공시에만 수행
	
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
<body data-ng-controller="detailController" class="container-fluid">
<!-- appendController : data 담당 / container-fluid : bootstrap, 여백 없음-->

<!-- 두 문서 간 연결 -->
<a href="list.jsp" class="btn btn-info">부서리스트로...</a>

<div>deptno = ${param.deptno}</div>
<div class="panel panel-default">
  <div class="panel-heading">부서 정보</div>
  <div class="panel-body">
  	<ul>
  		<li>{{dept.deptno}}</li>
  		<li>{{dept.dname}}</li>
  		<li>{{dept.loc}}</li>
  	</ul>
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