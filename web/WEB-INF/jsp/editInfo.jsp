<%--
  Created by IntelliJ IDEA.
  User: LSS
  Date: 2020-02-16
  Time: 5:14 a.m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>editInfo</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        small {
            font-color: red;
        }
    </style>
</head>
<body style="width: 40%; margin: auto;padding-top: 10%">
<script src="/js/angular.min.js"></script>
<div>
    <form method="post" ng-app="myApp"  ng-controller="validateCtrl" name="myForm" novalidate>
        <div class="form-group">
            <label for="telephone">Phone number:</label>
            <input type="text" class="form-control" id="telephone" name="telephone" ng-model="telephone" required>
            <small class="form-text text-muted" ng-show="myForm.telephone.$error.required">Phone number cannot be empty</small>
        </div>
        <div class="form-group">
            <label for="address">Address</label>
            <input type="text" class="form-control" id="address" name="address" ng-model="address" required>
            <small class="form-text text-muted" ng-show="myForm.address.$error.required">Address cannot be empty</small>
        </div>
        <input type="button" class="btn btn-primary" onclick="editInf()" value="Submit"
               ng-disabled="myForm.address.$error.required||myForm.telephone.$error.required"/>
    </form>
    <script>
        var app = angular.module('myApp', []);
        app.controller('validateCtrl', function ($scope) {
        });
    </script>
</div>
<script>
    function editInf() {
        var telephone = document.getElementById("telephone").value;
        var address = document.getElementById("address").value;
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var valid = xmlhttp.responseText;
                if (valid == "ok") {
                    alert("编辑成功！");
                    document.getElementById("editInf").style.display = "none";
                }
            }
        };
        var str = "telephone=" + telephone + "&address=" + address;
        xmlhttp.open("POST", "/editInf", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(str);
    }
</script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
