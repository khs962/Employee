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
<!-- AngularJS -->
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
<script type="text/javascript">

var app = angular.module('employee', []);

app.controller('listController', function($scope, $http) {
	alert("listController...");
	
	$scope.left = "왼쪽 Panel";
	$scope.right = "오른쪽 Panel";
	
	$scope.change = function(button) {
		//alert("change click... " + button);
		switch (button) {
		case "left":
			$scope.left += "#";
			break;
		case "center":
			$scope.left ="";
			$scope.right ="";
			$scope.depts = [
			    {deptno : 100, dname : "총무부", loc : "서울"}
			];
			break;
		case "right":
			$scope.right = "@" + $scope.right;
			break;	

		default:
			break;
		}
		
	};
	
	var ajax = $http.get('/Employee/dept/list');
	ajax.then(function(response) {
		console.dir(response);
		console.dir(response.data);
		$scope.depts = response.data;
	});
});
</script>

</head>
<body data-ng-controller="listController" class="container">
<div class="row">
	<div class="col-md-4"><button class="btn btn-primary" data-ng-click="change('left')">change</button></div>
	<div class="col-md-4"><button class="btn btn-success" data-ng-click="change('center')">change</button></div>
	<div class="col-md-4"><button class="btn btn-info"    data-ng-click="change('right')">change</button></div>
</div>
<div class="row">
	<div class="col-sm-4" style="background-color: red">{{left}}</div>
	<div class="col-sm-4" style="background-color: green">{{center}}<pre>{{depts}}</pre></div>
	<div class="col-sm-4" style="background-color: blue">{{right}}</div>
</div>
<hr>
<ul>
	<li data-ng-repeat="dept in depts">
		{{dept.deptno}} {{dept.dname}} {{dept.loc}}
	</li>
</ul>
<hr>
<table class="table table-striped table-bordered">
	<thead>
		<tr>
			<th>deptno</th><th>dname</th><th>loc</th>
		</tr>
	</thead>
	<tbody>
		<tr data-ng-repeat="d in depts">
			<td>{{d.deptno}}</td>
			<td>{{d.dname}}</td>
			<td>{{d.loc}}</td>
		</tr>
	</tbody>

</table>








</body>
</html>