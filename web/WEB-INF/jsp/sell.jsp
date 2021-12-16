<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        .form-group label{
            font-weight: bold;
        }
        .form-group label span{
            font-weight: normal;
            color: #e00000;
        }
    </style>
</head>
<body class="container" style="width: 70%; margin: auto">
<div class="row justify-content-center">
    <script src="/js/angular.min.js"></script>
    <form method="post" class="col-8" action="/addItems" enctype="multipart/form-data" ng-app="myApp" ng-controller="validateCtrl"
          name="myForm" id="addItems" novalidate>
        <div class="form-group">
            <label for="name"><span>*</span> Item name <span ng-show="myForm.name.$error.required">(Name is necessary)</span></label>
            <input type="text" class="form-control" name="name" ng-model="name" required/>
        </div>
        <div class="form-group">
            <label for="keyword"><span>*</span> Search keyword <span ng-show="myForm.keyWord.$error.required">(Keyword is required)</span></label>
            <input type="text" class="form-control" name="keyWord" ng-model="keyWord" required/>
        </div>
        <div class="form-group">
            <label for="price"><span>*</span> Price <span ng-show="myForm.price.$error.required">(Price is required)</span></label>
            <input type="text" class="form-control" name="price" ng-model="price" required/>
        </div>
        <div class="form-group">
            <label for="colorAndSize"><span>*</span> Color and Size <span ng-show="myForm.select.$error.required">(You must specify the color, size and price for your goods)</span></label>
            <input type="text" class="form-control" name="select" ng-model="select" required/>
        </div>
        <div class="form-group">
            <label for="description"><span>*</span> Description <span ng-show="myForm.description.$error.required">(Description is required)</span></label>
            <input type="text" class="form-control" name="description" ng-model="description" required/>
        </div>
        <div class="form-group">
            <label for="images"><span>*</span> Reference pictures (Upload at least one picture) <span id="error-img"></span></label>
        </div>
        <div class="input-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="image" name="image">
                <label class="custom-file-label">Choose file</label>
            </div>
        </div><br>
        <div class="input-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" name="image">
                <label class="custom-file-label">Choose file</label>
            </div>
        </div><br>
        <div class="input-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" name="image">
                <label class="custom-file-label">Choose file</label>
            </div>
        </div><br>
        <div class="input-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" name="image">
                <label class="custom-file-label">Choose file</label>
            </div>
        </div><br>
        <div class="input-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" name="image">
                <label class="custom-file-label">Choose file</label>
            </div>
        </div><br>
        <div class="input-group">
            <div class="custom-file">
                <input type="file" class="custom-file-input" name="image">
                <label class="custom-file-label">Choose file</label>
            </div>
        </div><br>
        <div class="form-group">
            <label for="type">Choose departments <span ng-show="myForm.description.$error.required">(You must choose a department for your goods)</span></label>
            <select name="typeSelect" class="form-control">
                <c:forEach items="${types}" var="type" varStatus="status">
                    <option value="${type.id}" <c:if test="${status.first}">selected</c:if>>${type.name}</option>
                </c:forEach>
            </select>
        </div>
        <input type="button" class="btn btn-primary" value="Post" ng-disabled="myForm.name.$error.required||myForm.keyWord.$error.required||myForm.price.$error.required||myForm.select.$error.required||myForm.description.$error.required
" onclick="checkImg()">
        <input type="reset" class="btn btn-secondary" value="Reset">
    </form>
        <script>
            var app = angular.module('myApp', []);
            app.controller('validateCtrl', function ($scope) {
                $scope.select = "example Red(size:M)-100|Yellow(size:S)-120|...";
            });
            function checkImg() {
                var id = document.getElementById("image");
                if (id.value.length == 0) {
                    document.getElementById("error-img").innerHTML = "Please upload at least one picture";
                } else {
                    document.getElementById("addItems").submit();
                }
            }
        </script>
</div>
<c:if test="${success}">
    <div class="row justify-content-center">
        <div class="col-7">
            <div class="alert alert-success" role="alert">
                Your goods is posted successfully
            </div>
        </div>
    </div>
</c:if>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
