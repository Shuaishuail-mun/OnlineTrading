<%@ page import="tian.table.User" %>
<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/14
  Time: 8:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%User user = (User) session.getAttribute("user");%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        body {
            font-family: 微软雅黑;
            font-size: 18px;
        }

        .big-div {
            margin: 0px auto;
            position: relative;
            width: 75%;
            background-color: rgba(202, 202, 202, 0.1);
            border: 1px solid rgba(118, 117, 122, 0.38);
            border-radius: 2px;
            padding: 5px;
        }

        .big-div input {
            position: absolute;
            right: 5%;
            top: 42%;
            height: 16%;
        }

        .big-div img {
            max-width: 100px;
            max-height: 100px;
            position: absolute;
            left: 2px;
        }
        .big-div div{
            margin-left: 120px;
        }
        .big-div button {
            background-color: transparent;
            border-radius: 2px;
            padding: 1px;
            padding-left: 5px;
            padding-right: 5px;
            border: 1px solid #bbc0c1;

        }

        #total-div {
            position: absolute;
            left: 40%;
            top: 10%;
            width: 20%;
            height: 400px;
            background-color: rgb(243, 243, 243);
            border: 1px solid #9d96a5;
            border-radius: 5px;
            text-align: center;
            display: none;

        }
        #total-div div{
            width: 60%;
            margin: auto;
            text-align: left;
        }
    </style>
    <script src="/js/jquery-1.11.3.js"></script>
    <script>
        function changeShow() {
            var sel = document.getElementsByName("select");
            var count = 0;
            var temp;
            var tempV;
            var price;
            var num;
            for (var i = 0; i < sel.length; i++) {

                temp = sel[i];
                if (temp.checked == true) {
                    tempV = temp.value;
                    price = parseFloat(document.getElementById(tempV).innerHTML);
                    num = parseInt(document.getElementById(tempV + "0").innerHTML);
                    count += price * num;
                }

            }
            document.getElementById("show").innerHTML = count;
        }
        function buyItems() {
            document.getElementById("total-div").style.display = "block";
            document.getElementById("total").innerHTML = document.getElementById("show").innerHTML;

        }
        var pays = 0;
        function pay() {
            pays = 1;
        }
        function check() {
            var records = "";
            var checkBox = document.getElementsByName("select");
            for (var i = 0; i < checkBox.length; i++) {
                if (checkBox[i].checked == true) {
                    records += checkBox[i].value + "-";
                }
            }
            var tele = document.getElementById("telephone").value;
            var addr = document.getElementById("address").value;
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
                        alert("购买成功!");
                        location.reload();
                    }

                }
            };

            var s = "pay=" + pays + "&records=" + records + "&tele=" + tele + "&addr=" + addr;
            xmlhttp.open("POST", "/changeToDone", true);
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp.send(s);
        }
        function deleteR() {
            var records = "";
            var checkBox = document.getElementsByName("select");
            for (var i = 0; i < checkBox.length; i++) {
                if (checkBox[i].checked == true) {
                    records += checkBox[i].value + "-";
                }
            }
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
                        alert("删除成功！");
                        location.reload();
                    }

                }
            };

            var s = "records=" + records;
            xmlhttp.open("POST", "/deleteR", true);
            xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xmlhttp.send(s);

        }
    </script>
</head>
<body style="width: 80%; margin: auto">
<br>
<div style="float:right;position: relative;right: 160px;">
    $ <span id="show" style="font-weight: bold">0</span>&nbsp;
    <button class="btn btn-outline-secondary" onclick="deleteR()">Delete</button>
    &nbsp;&nbsp;
    <button class="btn btn-outline-primary" onclick="buyItems()">Order now</button>
</div><br><br>
<c:forEach items="${arrayList}" var="array">
    <div class="big-div">
        <a href="/displayItem?id=${array[3]}">
            <img src="/upload/${array[3]}1.png?rad=<%=System.currentTimeMillis()%>">
        </a>
        <div>
            <h6>${array[0]}</h6>
            <p>${array[1]}<br>${array[4][0]}</p>
            <button id="${array[2]}">${array[4][1]}</button>
            *
            <button id="${array[2]}0">${array[5]}</button>
        </div>
        <input type="checkbox" name="select" value="${array[2]}" onclick="changeShow()">
    </div>
    <br>
</c:forEach>


<div id="total-div">
    <img src="/image/closing.png" style="width: 30px;height: 30px;position: inherit;right: 0px;top: 0px;"
         onclick="document.getElementById('total-div').style.display='';">
    <div>
    <br>

    In total $<span id="total"></span><br><br>
    <script src="/js/angular.min.js"></script>
    <form ng-app="myApp" ng-controller="validateCtrl" name="myForm" novalidate>
        Phone number<br><input type="text" id="telephone" name="telephone" ng-model="telephone" required><br><span
            style="color: red" ng-show="myForm.telephone.$error.required">required</span><br>
        Address<br><input type="text" id="address" name="address" ng-model="address" required><br><span style="color: red"
                                                                                                      ng-show="myForm.address.$error.required">required</span><br>
        <input type="button" class="btn btn-outline-primary" value="Pay" onclick="pay()"
               ng-disabled="myForm.address.$error.required||myForm.telephone.$error.required"/>
        <input type="button" class="btn btn-outline-dark" onclick="check()" value="Confirm"
               ng-disabled="myForm.address.$error.required||myForm.telephone.$error.required"/>
    </form>
    <script>
        var app = angular.module('myApp', []);
        app.controller('validateCtrl', function ($scope) {
            $scope.telephone = "${user.telNum}";
            $scope.address = "${user.address}";
        });
    </script>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
