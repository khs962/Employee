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
	
	ajax.then(function(res) {		// 성공 시(200)
		console.dir(res);
		$scope.response = res.data;	// 성공 시 들어오는 data
	}, function(res) {				// 실패했을 경우 (404, 500)
		console.dir(res);
	});
});
</script>
</head>
<body data-ng-controller="listController" class="container">
<div class="row">
	<div class="col-md-4">{{response.success}}</div>
	<div class="col-md-4">{{response.message}}</div>
	<div class="col-md-4"><pre>{{response.data}}</pre></div>
</div>

<table class="table table-striped">
	<thead>
		<tr><th>empno</th><th>ename</th></tr>
	</thead>
	<tbody>
		<tr data-ng-repeat="emp in response.data">
			<td>{{emp.empno}}</td><td>{{emp.ename}}</td>
		</tr>
	</tbody>
</table>
</body>
</html>