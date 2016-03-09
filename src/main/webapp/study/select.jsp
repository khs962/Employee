<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="employee">
<head>
<meta charset="UTF-8">
<title>select.jsp</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- AngularJS library -->
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<!-- UI bootstrap (앵귤러JS 다음에 꼭 붙일것) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.2.4/ui-bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.2.4/ui-bootstrap-tpls.min.js"></script>

<script type="text/javascript">
var app = angular.module('employee', ['ui.bootstrap']); // employee 모듈에서 ui-bootstrap을 쓰겠다 라는 말
														// [] 배열 안에 여러  UI를 삽입 가능 [, , ,] 사용
app.controller('listController', function($scope, $http){	
	
	var ajax = $http.get("/Employee/emp/mgrs");
	
	ajax.then(function(value) {		// 성공 시(200)
		console.dir(value);
		$scope.mgrs = value.data;	// 성공 시 들어오는 data
	});
	
	$scope.emp = {  		//empno가 필수 입력사항이라 empno에 10값을 준것
			empno : 10
	}

// 	$scope.mgrs = [
// 		{empno : 10, ename : "힝길뚱1"},
// 		{empno : 20, ename : "힝길뚱2"},
// 		{empno : 30, ename : "힝길뚱3"},
// 		{empno : 40, ename : "힝길뚱4"},
// 		{empno : 50, ename : "힝길뚱5"},
		
// 	];
	
	$scope.submit = function(){
		var ajax = $http.post("/Employee/emp", $scope.emp)
		ajax.then(function(value) {
			console.dir(value);
			
		});
		
	};
	
	
	$scope.isOpen = false;
	$scope.open = function(){
		$scope.isOpen=true;
	};
	
	$scope.clear = function(){
		$scope.emp.hiredate = null;	
	};
});
</script>
</head>
<body data-ng-controller="listController" class="container">
<h1>select option 연습</h1>
<form name="empForm" data-ng-submit="submit()">
<pre>{{emp}}</pre>
<input name="empno" type="hidden" data-ng-model="emp.empno" value="20"/>   <!-- 스코프 대신에 hidden으로 값을 숨겨넣어줌 
결과 : 안됌 다시 스코프로 값을 받아야 함-->
<select name="mgr" data-ng-model="emp.mgr">
	<option value=""> --선택하세요 -- </option>
	<option data-ng-repeat="mgr in mgrs" value="{{mgr.empno}}">{{mgr.empno}}  {{mgr.ename}}</option>
</select>
<hr>
 <div class="input-group">
          <input type="text" class="form-control"
          		 data-ng-model="emp.hiredate" 
          		 class="form-control" 
          		 data-uib-datepicker-popup 
          		 data-is-open="isOpen" 
          		 readonly="readonly" 
          		 />
          		 <!-- readonly - 수정 할 수 없고 읽을 수만 있게 함 -->
          <span class="input-group-btn">
            <button type="button" class="btn btn-default" data-ng-click="open()">
            	<i class="glyphicon glyphicon-hand-up"></i>
            </button>
          </span>
          <span class="input-group-btn">
            <button type="button" class="btn btn-default" data-ng-click="clear()">
            	<i class="glyphicon glyphicon-remove"></i>
            </button>
          </span>
          
</div>
<hr>
<button type="submit" class="btn btn-info">전송</button>
</form>
</body>
</html>