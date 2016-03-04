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
app.controller('listController', function($scope, $http){	
	// app.controller : angular controller
	// body에서 data-ng-controller="listController"를 만난 후 이 함수로 들어온다
	// alert("listController...");
	console.log("listController...");

	// $scope : map 객체, View와 긴밀히 연동 
	// $http : map, Ajax를 호출하기 위해 미리 만들어놓은 객체
	
	// 바인딩 개념 이해
	$scope.left = "왼쪽 Panel";
	$scope.right = "오른쪽 Panel";
	
	$scope.change = function(button){
		alert("change click..." + button);
		
		switch (button) {
		case "left":
			$scope.left += " #";
			break;
		case "center":
			$scope.left = "";
			$scope.right = "";
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
	
	var ajax = $http.get('/Employee/dept/list');	// json으로 받은 결과를 ajax 변수에 저장
	ajax.then(function(response){	// ajax 호출하여 에러가 없이 성공하면 함수호출
		console.dir(response);		// log 확인
		console.dir(response.data);
		$scope.depts = response.data;	// $scope : map 객체, depts : key, 배열(4개)
		// Ajax로 받아온 데이터를 scope에 저장하고, View에 바인딩하기 위해
		// body에서 listController와 관련된 {{}} expression을 찾고 이에 해당하는 key 출력
	});
});

</script>
</head>
<body data-ng-controller="listController" class="container-fluid">
<!-- listController : data 담당 -->
<!-- $scope 바인딩 이해를 위한 Test -->
<div class="row">
	<!-- md : tablet size -->
	<!-- ng-click : 클릭 이벤트 지시어 -->
	<div class="col-md-4"><button class="btn btn-primary" data-ng-click="change('left')">change</button></div>
	<div class="col-md-4"><button class="btn btn-success" data-ng-click="change('center')">change</button></div>
	<div class="col-md-4"><button class="btn btn-info" data-ng-click="change('right')">change</button></div>
</div>

<div class="row">
	<div class="col-sm-4" style="background-color: red">{{left}}</div>
	<div class="col-sm-4" style="background-color: green"><pre>{{message}}</pre></div>
	<!-- <div class="col-sm-4" style="background-color: green">{{center}}<pre>{{depts}}</pre></div>	
		model에 있는 데어터를 읽는 방법 : {{data}} -->
	<div class="col-sm-4" style="background-color: blue">{{right}}</div>
</div>

<hr>
<div class="row">
														<!-- input의 value값으로 들어감 -->
	<div class="col-sm-4" style="background-color: red"><input data-ng-model="left"/></div>
	<!-- textarea일 경우에는 value속성이 없으므로 알아서 textarea 값으로 -->
	<!-- textarea 값으로 어떤 값을 넣어도 바인딩되는 값으로 들어감 -->
	<!-- depts객체를 json string으로 알아서 변환해주지 않으므로 위 코드에서 depts를 string으로 변환 -->
	<div class="col-sm-4" style="background-color: green"><textarea rows="10" data-ng-model="message"></textarea></div>	<!-- model에 있는 데어터를 읽는 방법 : {{data}} -->
	<div class="col-sm-4" style="background-color: blue"><input data-ng-model="right"/></div>
</div>

<hr>
<!-- 양방향 바인딩 -->
<!-- model이라는 지시어에 의해 양방향 바인딩 -->
<!-- left라고 쓰기만해도 expressioon을 대신 -->
<!-- 그러므로  input에 들어온 left를 변경하면 left는 모두 변경됨 -->
<input data-ng-model="left"/>	

<hr>
<!-- depts(배열)을 각각의 요소로 출력 -->
<ul>
	<!-- repeat : angular의 반복 지시어 (향상된 for문과 흡사) -->
	<!-- depts : scope의 depts 배열 -->
	<li data-ng-repeat="dept in depts">
		{{dept.deptno}} {{dept.dname}} {{dept.loc}}
	</li>
</ul>

<hr>
<!-- 부서추가 링크 -->
<a href="append.jsp" class="btn btn-success">부서추가</a>

<hr>
<table class="table table-bordered table-striped table-hover">
	<thead>
		<tr>
			<th>deptno</th>
			<th>dname</th>
	 		<th>loc</th>
		</tr>
	</thead>
	<tbody>
		<tr data-ng-repeat="dept in depts">
			<td>{{dept.deptno}}</td>
			<td>{{dept.dname}}</td>
			<td>{{dept.loc}}</td>
		</tr>
	</tbody>
</table>
</body>
</html>