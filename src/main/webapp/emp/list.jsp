<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="employee">
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
var app = angular.module('employee', []);

app.controller('listController', function($scope, $http){	
	
	var ajax = $http.get("/Employee/emp/list");
	
	ajax.then(function(value) {		// 성공 시(200)
		console.dir(value);
		$scope.emps = value.data;	// 성공 시 들어오는 data
	});
	
});
</script>
</head>
<body data-ng-controller="listController" class="container">
<br/><br/>
<a href="append.jsp" class="btn btn-success">직원 추가</a>
<br/>
<h1>직원 리스트</h1>
<table class="table table-striped">
	<thead>
		<tr>
			<th>empno</th>
			<th>ename</th>
			<th>job</th>
			<th>mgr</th>
			<th>hiredate</th>
<!-- 		<th>sal</th> -->
<!-- 		<th>comm</th> -->
			<th>수정</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody>
		<tr data-ng-repeat="emp in emps">
			<td>{{emp.empno}}</td>
			<td><a href="detail.jsp?empno={{emp.empno}}">{{emp.ename}}</a></td>
			<td>{{emp.job}}</td>
			<td>{{emp.mgr}}</td>
			<td>{{emp.hiredate | date : 'yyyy년 MM월 dd일'}}</td>
			<td><a href="update.jsp?empno={{emp.empno}}"><i class="glyphicon glyphicon-edit"></i></a></td>
			<td><a href="delete.jsp?empno={{emp.empno}}"><i class="glyphicon glyphicon-trash"></i></a></td>
		</tr>
	</tbody>
</table>
</body>
</html>