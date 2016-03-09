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
<!-- UI bootstrap (앵귤러JS 다음에 꼭 붙일것) -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.2.4/ui-bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/1.2.4/ui-bootstrap-tpls.min.js"></script>

<script type="text/javascript">
var app = angular.module('employee', ['ui.bootstrap']);	// angular의 module생성 

//controller 생성, $: angular에서 미리 제공하는 모델객체
app.controller('appendController', function($scope, $http){	
	// app.controller : angular controller
	// body에서 data-ng-controller="appendController"를 만난 후 이 함수로 들어온다
	// alert("appendController...");
	console.log("appendController...");

	// $scope : map 객체, View와 긴밀히 연동 
	// $http : map, Ajax를 호출하기 위해 미리 만들어놓은 객체
	
	/* 
	mgr
	*/
	var ajax = $http.get("/Employee/emp/mgrs");
	ajax.then(function(value) {		// 성공 시(200)
		console.dir(value);
		$scope.mgrs = value.data;	// 성공 시 들어오는 data
	});
	/* 
	depts
	*/
	var ajax = $http.get("/Employee/dept/list");
	ajax.then(function(value) {		// 성공 시(200)
		console.dir(value);
		$scope.depts = value.data;	// 성공 시 들어오는 data
	});
	/* 
	hiredate
	*/
	$scope.isOpen = false;
	
	$scope.open = function(){
		$scope.isOpen=true;
	};
	
	$scope.clear = function(){
		$scope.emp.hiredate = null;	
// 		delete $scope.emp.hiredate;
	};
	
	
	$scope.submit = function(){
		var ajax = $http.post("/Employee/emp",$scope.emp);
		ajax.then(function(value) {
			console.dir(value);
			if(value.data.success){
				location.href ="list.jsp";
			}else{
				alert(value.data.message);
			}
		}, function(reason) {
			console.dir(reason);
		});
	};
	

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

	
	

	$scope.format = function(){
		var json = JSON.stringify(emoForm, null, 5);	// 서버에서 deptForm객체를 json string으로 변환함
		
		return json;
	}
	
});

</script>
</head>
<body data-ng-controller="appendController" class="container-fluid">
<!-- appendController : data 담당 / container-fluid : bootstrap, 여백 없음-->
<br/>
<!-- 두 문서 간 연결 -->
<a href="list.jsp" class="btn btn-info">부서리스트로...</a>
<hr>
<!-- 바인딩 확인 -->
<pre>{{emp}}</pre>

<!-- format() : model에 있는 format 객체를 binding처리하여 form tag에 변경이 있으면 자동 바인딩 -->
<!-- <textarea rows="10" cols="100">{{format()}}</textarea> -->

<ul>
	<li>empForm.$dirty = {{empForm.$dirty}} </li>	<!-- 사용자가 입력을 한 번이라도 한 경우 dirty=true -->
	<li>empForm.$valid = {{empForm.$valid}} </li>	<!-- invalid와 상호배타적 -->
	<li>empForm.$invalid = {{empForm.$invalid}} </li>	
	<!-- 하나라도 유효성 검사(모두 필수입력이 되어있어야 함)를 통과하지 못할경우 invalid=true -->
	
	<!-- deptForm 각각 요소에 대한 객체 존재 -->
	<li>empForm.empno.$dirty = {{empForm.empno.$dirty}}</li>
	<li>empForm.empno.$valid = {{empForm.empno.$valid}}</li>
	<li>empForm.empno.$invalid = {{empForm.empno.$invalid}}</li>
	<li>empForm.empno.$error = {{empForm.empno.$error}}</li>
	<li>empForm.ename.$error = {{empForm.ename.$error}}</li>
	
</ul>



<!-- 입력양식, submit page는 ajax로 처리 -->
<!-- validation : 유효한 값만 입력할 수 있도록 입력한 값에 대한 feedback 필요 -->
<!-- novalidate : web browser에서는 validation처리를 하지 않고 angular에서 처리하겠다는 의미 -->
<!-- form name을 dept로 할 경우 form을 dept객체로 인식하므로 form name과
	binding하려는 model이름을 달리해야함  -->
<form name="empForm" novalidate="novalidate" data-ng-submit="submit()">
	<!-- Bootstrap -->
	<!-- deptno -->
	<div class="form-group">
		<!-- label for = input의 id와 동일하게 하여야 label을 click했을 때 focus -->
		<label for="empno">직원 번호 : </label>
		<input id="empno"
			   type="number"
			   name="empno"
			   class="form-control"
			   data-ng-model="emp.empno"
			   required="required"
			   data-ng-min="1000"	
			   data-ng-max="9999"
			   
			   />
			   
			   <!-- type="number" only 2자리 숫자, 문자입력 시 invalid=true, valid 할 경우에만 empno로 저장됨-->
			   <!-- 양방향바인딩, 자동으로 scope 밑의 empno로 자동적으로 변수가 만들어지며
			   empno 라는 이름으로 바인딩 됨,
			   타이핑하면 화면에 보여지는 "deptno" -->
			   <!-- required : 필수입력항목 -->
			   <!-- ng-min 과 max 는 1000~9999까지 범위 지정 -->
	</div>
	<div data-ng-show="empForm.empno.$dirty">
		<div data-ng-show="empForm.empno.$error.required">필수입력 항목입니다.</div>
		<div data-ng-show="empForm.empno.$error.number">숫자만 입력가능합니다 0-99</div>
		<div data-ng-show="empForm.empno.$error.max">9999까지 입력가능합니다.</div>
		<div data-ng-show="empForm.empno.$error.min">1000이상 입력가능합니다.</div>
		<br/>
		<!-- 각항목에 맞게 조건 처리 : 각각 피드백을 줘야 한다. -->
	</div>
	
	<!-- dname -->
	<div class="form-group">
		<label for="ename">직원 이름 : </label>
		<input id="ename"
		 	   name="ename"
		 	   class="form-control"
		 	   data-ng-model="emp.ename"
		 	   data-ng-maxlength="10"
		 	   required="required"/>
		 	   
		 	   <!--   data-ng-maxlength="10" : 10자리 까지 문자허용
		 	   
		 	   
		 	   		 pattern="[a-z]{1,14}"  
		 	   		pattern 영문자 13자리 까지 허용
		 	   		[a-z]{10,14} 10~14자리 까지 영문자허용
		 	    -->
	</div>
	<!-- 각항목에 맞게 조건 처리 : dname -->
	<div data-ng-hide="!empForm.ename.$dirty">
		<div data-ng-hide="!empForm.ename.$error.required">필수 입력 항목 입니다.</div>
		<div data-ng-hide="!empForm.ename.$error.maxlength">10자리까지 입력가능합니다.</div>
		
	</div>
	
	
	<!-- job -->
	<div class="form-group">
		<label for="job">직업 : </label>
		<input id="job"
			   name="job"
			   class="form-control"
			   data-ng-model="emp.job"
			    data-ng-maxlength="9"/>
	</div>
	<!-- 각항목에 맞게 조건 처리: loc -->
	<div data-ng-hide="!empForm.job.$dirty">
		<div data-ng-hide="!empForm.job.$error.maxlength">9자리까지 입력가능합니다.</div>
		
	</div>
	
 	<!-- mgr --> 
<!-- 	<div class="form-group"> -->
<!-- 		<label for="mgr">매니저 번호 : </label> -->
<!-- 		<input id="mgr" -->
<!-- 			   name="mgr" -->
<!-- 			   class="form-control" -->
<!-- 			   data-ng-model="emp.mgr" -->
<!-- 			   data-ng-max="9999" -->
<!-- 			   data-ng-min="1000" -->
<!-- 			   /> -->
<!-- 	</div> -->
<!-- 	<div data-ng-show="empForm.mgr.$dirty"> -->
<!-- 		<div data-ng-show="empForm.mgr.$error.number">숫자만 입력가능합니다 0-99</div> -->
<!-- 		<div data-ng-show="empForm.mgr.$error.max">9999까지 입력가능합니다.</div> -->
<!-- 		<div data-ng-show="empForm.mgr.$error.min">1000이상 입력가능합니다.</div> -->
<!-- 		<br/> -->
<!-- 	</div> -->
	
	
	<!-- mgr --> 
	<div class="form-group">
		<label for="mgr">mgr : </label>
		<select id="mgr" name="mgr" data-ng-model="emp.mgr" class="form-control">
			<option value=""> --선택하세요 -- </option>
			<option data-ng-repeat="mgr in mgrs" value="{{mgr.empno}}">{{mgr.empno}}  {{mgr.ename}}</option>
		</select>
	</div>
	
	<!-- hiredate -->
	<div class="form-group">
		<label for="hiredate">hiredate :</label>
 		<div class="input-group">
          <input id="hiredate"
          		 type="text" class="form-control"
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
	</div>
	<!-- sal -->
	<div class="form-group">
		<!-- label for = input의 id와 동일하게 하여야 label을 click했을 때 focus -->
		<label for="sal">sal : </label>
		<input id="sal"
			   type="number"
			   name="sal"
			   class="form-control"
			   data-ng-model="emp.sal"
			   data-ng-min="0"	
			   data-ng-max="9999999"
			   
			   />
			   
	</div>
	<div data-ng-show="empForm.sal.$dirty">
		<div data-ng-show="empForm.sal.$error.number">숫자만 입력가능합니다 0-9999999</div>
		<div data-ng-show="empForm.sal.$error.max">9999999까지 입력가능합니다.</div>
		<div data-ng-show="empForm.sal.$error.min">0이상 입력가능합니다.</div>
		<br/>
	</div>
	<!-- comm -->
		<div class="form-group">
		<!-- label for = input의 id와 동일하게 하여야 label을 click했을 때 focus -->
		<label for="comm">comm : </label>
		<input id="comm"
			   type="number"
			   name="comm"
			   class="form-control"
			   data-ng-model="emp.comm"
			   data-ng-min="0"	
			   data-ng-max="9999999"
			   
			   />
			   
	</div>
	<div data-ng-show="empForm.comm.$dirty">
		<div data-ng-show="empForm.comm.$error.number">숫자만 입력가능합니다 0-9999999</div>
		<div data-ng-show="empForm.comm.$error.max">9999999까지 입력가능합니다.</div>
		<div data-ng-show="empForm.comm.$error.min">0이상 입력가능합니다.</div>
		<br/>
	</div>
	<!-- deptno --> 
	<div class="form-group">
		<label for="deptno">deptno : </label>
		<select id="deptno" name="deptno" data-ng-model="emp.deptno" class="form-control">
			<option value=""> --선택하세요 -- </option>
			<option data-ng-repeat="dept in depts" value="{{dept.deptno}}">{{dept.deptno}}  {{dept.dname}}</option>
		</select>
	</div>
<hr>
	<button type="submit" data-ng-disabled="empForm.$invalid" class="btn btn-warning">직원추가</button>
</form>

</body>
</html>