<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/6
  Time: 22:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        body{
            font-family: 微软雅黑;
            width: 80%;
            margin: auto;
        }
        .div {

            width: 98.3%;
            height: 540px;
            border-radius:8px;
            padding: 10px;

        }

        .s-div {
            width: 24.5%;
            height: 330px;
            position: relative;
            background-color: rgb(255, 255, 255);
            text-align: center;
          /*  padding: 5px;*/
            float: left;
        }

        .s-div div {
            opacity:0.3;
            width:77px;
            height: 330px;
            text-align: center;
            background-size: 100% 100%;
        }

        .s-div div:hover {
            opacity: 0.7;
        }

        label {
            border-radius: 3px;

        }

        button {
            background-color: transparent;
            border: 1px #8f8f8f solid;
            border-radius: 2px;
        }

        button:hover {
            background-color: rgba(217, 221, 221, 0.99);
        }

        .sell-div {
            width:40%;
            height: 530px;
            margin-left: 80px;


        }
        .sell-div input{
            background-color: transparent;
            font-family: 微软雅黑;
            border: 1px solid rgba(171, 165, 168, 0.72);
            border-radius:2px;
            height: 24px;
        }
        .sell-div span{
            color: #ff001d;
        }
        .sell-div input[name="image"]{
            border: none;
            text-decoration: none;

        }
        select{
            font-family: 微软雅黑;
        }
    </style>
    <script>
        var num=1;
        var pre="/upload/${item.id}";
        var last=".png";
        var all=${item.imageNum};
        function change(id){
         if(id.id=="left"){
             if(num==1){num=all;}
             else{num--;}
         }else{
             if(num==all){num=1;}
             else{num++;}
         }
            document.getElementById("img").src=pre+num+last+"?rad="+Math.random();
        }
        function showPrice(id){
            document.getElementById("sPrice").innerHTML=id.value;
        }
    </script>

</head>
<body><br>
<c:if test="${ok}"><script>alert("Successfully modified")</script></c:if>
<br>
<div class="container-fluid">
    <script src="/js/angular.min.js"></script>
    <div class="row justify-content-center">
        <div class="col-10">
        <form method="post" action="/editItems?id=${item.id}" enctype="multipart/form-data" ng-app="app" ng-controller="validateCtrler"
              style="position: relative;left: 130px;top:10px;" id="editItems"
              name="myForm" novalidate>
            <div class="form-group">
                <label>Name</label>
                <input type="text" class="form-control" name="name" ng-model="name" required/>
                <small class="form-text text-muted" ng-show="myForm.name.$error.required">This area is required</small>
            </div>
            <div class="form-group">
                <label>Key words</label>
                <input type="text" class="form-control" name="keyWord" ng-model="keyWord" required/>
                <small class="form-text text-muted" ng-show="myForm.keyWord.$error.required">This area is required</small>
            </div>
            <div class="form-group">
                <label>Price</label>
                <input type="text" class="form-control" name="price" ng-model="price" required/>
                <small class="form-text text-muted" ng-show="myForm.price.$error.required">This area is required</small>
            </div>
            <div class="form-group">
                <label>Color and Size</label>
                <input type="text" class="form-control" name="select" ng-model="select" required/>
                <small class="form-text text-muted" ng-show="myForm.select.$error.required">This area is required</small>
            </div>
            <div class="form-group">
                <label>Description</label>
                <input type="text" class="form-control" name="description" ng-model="description" required/>
                <small class="form-text text-muted" ng-show="myForm.description.$error.required">This area is required</small>
            </div>
            <div class="form-group">
                <label for="images">Reference pictures (Upload at least one picture)</label>
            </div>
            <div class="input-group">
                <div class="custom-file">
                    <input type="file" id="image" name="image" class="custom-file-input" id="image" name="image">
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
                <label for="type">Choose department</label>
                <select name="typeSelect" class="form-control">
                    <c:forEach items="${types}" var="type" varStatus="status">
                        <option value="${type.id}" <c:if test="${type.id==sType.id}">selected="selected"</c:if>>${type.name}</option>
                    </c:forEach>
                </select>
            </div>
            <input type="button" class="btn btn-primary" value="Modify" ng-disabled="myForm.name.$error.required||myForm.keyWord.$error.required||myForm.price.$error.required||myForm.select.$error.required||myForm.description.$error.required
" onclick="checkImg()">&nbsp;&nbsp;<input class="btn btn-secondary" type="reset" value="Reset">
        </form>
        </div>
        <script>
            var app = angular.module('app', []);
            app.controller('validateCtrler', function ($scope) {
                $scope.name ="${item.name}";
                $scope.keyWord ="${item.keyWord}";
                $scope.price ="${item.price}";
                $scope.select ="${item.sel}";
                $scope.description ="${item.description}";
            });
            function checkImg() {
                var id = document.getElementById("image");
                if (id.value.length == 0) {
                    document.getElementById("error-img").innerHTML = "Choose at least one picture";
                } else {
                    document.getElementById("editItems").submit();
                }
            }
        </script>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
