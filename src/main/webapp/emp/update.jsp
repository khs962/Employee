<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html data-ng-app="employee">	<!-- ng-app는 표준에 맞지 않아 warning이 나므로 앞에 data붙여줌 -->
<head>
<meta charset="UTF-8">
<title>update.jsp</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<!-- AngularJS library -->
<script src="http://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>

<script type="text/javascript">
var app = angular.module('employee', []);	// angular의 module생성 

//controller 생성, $: angular에서 미리 제공하는 모델객체
app.controller('updateController', function($scope, $http){	
	// app.controller : angular controller
	// body에서 data-ng-controller="appendController"를 만난 후 이 함수로 들어온다
	// alert("appendController...");
	console.log("updateController...");

	// $scope : map 객체, View와 긴밀히 연동 
	// $http : map, Ajax를 호출하기 위해 미리 만들어놓은 객체
	
	$scope.deptno = ${param.deptno};
	$scope.dept = {};
	//서버에서 param의 deptno 값을 가져와야한다.
	var ajax = $http.get("/Employee/dept?deptno=" + $scope.deptno);
	ajax.then(function(value) {
		$scope.dept = value.data;
	});
	
	$scope.submit = function(){
		var ajax = $http.put("/Employee/dept", $scope.dept);
		ajax.then(function(value) {
			if(value.data.success){
				alert(value.data.message);
				location.href = "list.jsp";	
			}else{
				alert(value.data.message);
			}
		}, function(reason) {
			console.dir(reason);
				
		});
		
		
	};
	// submit 버튼이 눌리면 함수가 실행됨
	// put으로 dept바디를 넘겨야 한다.
});


</script>
</head>
<body data-ng-controller="updateController" class="container-fluid">
<!-- appendController : data 담당 / container-fluid : bootstrap, 여백 없음-->

<!-- 두 문서 간 연결 -->
<a href="list.jsp" class="btn btn-info">부서리스트로...</a>

<!-- 바인딩 확인 -->
<pre>{{dept}}</pre>
<br/>
<h1>부서수정</h1>
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
	<li>deptForm.deptname.$error = {{deptForm.dname.$error}}</li>
	<li>deptForm.deptloc.$error = {{deptForm.loc.$error}}</li>
</ul>



<!-- 입력양식, submit page는 ajax로 처리 -->
<!-- validation : 유효한 값만 입력할 수 있도록 입력한 값에 대한 feedback 필요 -->
<!-- novalidate : web browser에서는 validation처리를 하지 않고 angular에서 처리하겠다는 의미 -->
<!-- form name을 dept로 할 경우 form을 dept객체로 인식하므로 form name과
	binding하려는 model이름을 달리해야함  -->
<form name="deptForm" novalidate="novalidate" data-ng-submit="submit()">
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
			   required="required"
			   data-ng-min="0"	
			   data-ng-max="99"
			   readonly="readonly"
			   
			   />
			   <!--readonly="readonly" 과 disabled="disabled" 같다  -->
			   <!-- type="number" only 2자리 숫자, 문자입력 시 invalid=true, valid 할 경우에만 deptno로 저장됨-->
			   <!-- 양방향바인딩, 자동으로 scope 밑의 deptno로 자동적으로 변수가 만들어지며
			   deptno 라는 이름으로 바인딩 됨,
			   타이핑하면 화면에 보여지는 "deptno" -->
			   <!-- required : 필수입력항목 -->
			   <!-- ng-min 과 max 는 0~99까지 범위 지정 -->
	</div>
	<div data-ng-show="deptForm.deptno.$dirty">
		<div data-ng-show="deptForm.deptno.$error.required">필수입력 항목입니다.</div>
		<div data-ng-show="deptForm.deptno.$error.number">숫자만 입력가능합니다 0-99</div>
		<div data-ng-show="deptForm.deptno.$error.max">99까지 입력가능합니다.</div>
		<div data-ng-show="deptForm.deptno.$error.min">0이상 입력가능합니다.</div>
		<br/>
		<!-- 각항목에 맞게 조건 처리 : 각각 피드백을 줘야 한다. -->
	</div>
	<!-- dname -->
	<div class="form-group">
		<label for="dname">부서이름 : </label>
		<input id="dname"
		 	   name="dname"
		 	   class="form-control"
		 	   data-ng-model="dept.dname"
		 	  
		 	   data-ng-maxlength="14"
		 	   required="required"/>
		 	   
		 	   <!--   data-ng-maxlength="15" : 15자리 까지 문자허용
		 	   
		 	   
		 	   		 pattern="[a-z]{1,14}"  
		 	   		pattern 영문자 13자리 까지 허용
		 	   		[a-z]{10,14} 10~14자리 까지 영문자허용
		 	    -->
	</div>
	<!-- 각항목에 맞게 조건 처리 : dname -->
	<div data-ng-hide="!deptForm.dname.$dirty">
		<div data-ng-hide="!deptForm.dname.$error.required">필수 입력 항목 입니다.</div>
		<div data-ng-hide="!deptForm.dname.$error.maxlength">14자리까지 입력가능합니다.</div>
		
	</div>
	
	
	<!-- loc -->
	<div class="form-group">
		<label for="loc">부서위치 : </label>
		<input id="loc"
			   name="loc"
			   class="form-control"
			   data-ng-model="dept.loc"
			    data-ng-maxlength="13"
			   required="required"/>
	</div>
	<!-- 각항목에 맞게 조건 처리: loc-->
	<div data-ng-hide="!deptForm.loc.$dirty">
		<div data-ng-hide="!deptForm.loc.$error.required">필수 입력 항목 입니다.</div>
		<div data-ng-hide="!deptForm.loc.$error.maxlength">13자리까지 입력가능합니다.</div>
		
	</div>
	
	
	<!-- invalid=true일 경우 button이 disable되어야 함 -->
	<button type="submit" data-ng-disabled="deptForm.$invalid" class="btn btn-warning">부서 수정</button>
</form>

</body>
</html>