<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="employee">	<!-- ng-app는 표준에 맞지 않아 warning이 나므로 앞에 data붙여줌 -->
<head>
<meta charset="UTF-8">
<title>list.jsp</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- AngularJS library -->
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>

<script type="text/javascript">
var app = angular.module('employee', []);	// angular의 module생성 

//controller 생성, $: angular에서 미리 제공하는 모델객체
app.controller('appendController', function($scope, $http){	
	// app.controller : angular controller
	// body에서 data-ng-controller="appendController"를 만난 후 이 함수로 들어온다
	// alert("appendController...");
	console.log("appendController...");

	// $scope : map 객체, View와 긴밀히 연동 
	// $http : map, Ajax를 호출하기 위해 미리 만들어놓은 객체
	
	/*
	초기값이 없으면 양방향 바인딩에 의해 알아서 만들어짐
	$scope.data = {
			deptno : 10,
			dname : "총무부",
			loc : "서울"
	}; */
	
	$scope.format = function(){
		var json = JSON.stringify(deptForm, null, 5);	// 서버에서 deptForm객체를 json string으로 변환함
		
		return json;
	}

});

</script>
</head>
<body data-ng-controller="appendController" class="container-fluid">
<!-- appendController : data 담당 / container-fluid : bootstrap, 여백 없음-->

<!-- 두 문서 간 연결 -->
<a href="list.jsp" class="btn btn-info">부서리스트로...</a>

<!-- 바인딩 확인 -->
<pre>{{dept}}</pre>

<!-- format() : model에 있는 format 객체를 binding처리하여 form tag에 변경이 있으면 자동 바인딩 -->
<!-- <textarea rows="10" cols="100">{{format()}}</textarea> -->

<ul>
	<li>deptForm.$dirty = {{deptForm.$dirty}} </li>	<!-- 사용자가 입력을 한 번이라도 한 경우 dirty=true -->
	<li>deptForm.$valid = {{deptForm.$valid}} </li>	<!-- invalid와 상호배타적 -->
	<li>deptForm.$invalid = {{deptForm.$invalid}} </li>	
	<!-- 하나라도 유효성 검사(모두 필수입력이 되어있어야 함)를 통과하지 못할경우 invalid=true -->
	
	<!-- deptForm 각각 요소에 대한 객체 존재 -->
	<li>deptForm.deptno.$dirty = {{deptForm.deptno.$dirty}}</li>
	<li>deptForm.deptno.$valid = {{deptForm.deptno.$valid}}</li>
	<li>deptForm.deptno.$invalid = {{deptForm.deptno.$invalid}}</li>
	<li>deptForm.deptno.$error = {{deptForm.deptno.$error}}</li>
</ul>

<!-- 입력양식, submit page는 ajax로 처리 -->
<!-- validation : 유효한 값만 입력할 수 있도록 입력한 값에 대한 feedback 필요 -->
<!-- novalidate : web browser에서는 validation처리를 하지 않고 angular에서 처리하겠다는 의미 -->
<!-- form name을 dept로 할 경우 form을 dept객체로 인식하므로 form name과
	binding하려는 model이름을 달리해야함  -->
<form name="deptForm" novalidate="novalidate">
	<!-- Bootstrap -->
	<!-- deptno -->
	<div class="form-group">
		<!-- label for = input의 id와 동일하게 하여야 label을 click했을 때 focus -->
		<label for="deptno">부서번호 : </label>
		<input id="deptno"
			   type="number"
			   name="deptno"
			   class="form-control"
			   data-ng-model="dept.deptno"
			   required="required"/>
			   <!-- type="number" only 2자리 숫자, 문자입력 시 invalid=true, valid 할 경우에만 deptno로 저장됨-->
			   <!-- 양방향바인딩, 자동으로 scope 밑의 deptno로 자동적으로 변수가 만들어지며
			   deptno 라는 이름으로 바인딩 됨,
			   타이핑하면 화면에 보여지는 "deptno" -->
			   <!-- required : 필수입력항목 -->
	</div>
	
	<!-- dname -->
	<div class="form-group">
		<label for="dname">부서이름 : </label>
		<input id="dname"
		 	   name="dname"
		 	   class="form-control"
		 	   data-ng-model="dept.dname"
		 	   required="required"/>
	</div>
	
	<!-- loc -->
	<div class="form-group">
		<label for="loc">부서위치 : </label>
		<input id="loc"
			   name="loc"
			   class="form-control"
			   data-ng-model="dept.loc"
			   required="required"/>
	</div>
	
	<!-- invalid=true일 경우 button이 disable되어야 함 -->
	<button type="submit" data-ng-disabled="deptForm.$invalid" class="btn btn-warning">부서추가</button>
</form>

</body>
</html>