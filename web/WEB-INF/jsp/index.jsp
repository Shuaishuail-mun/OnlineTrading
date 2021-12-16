<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link href="/css/index.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style>
        html,body{ margin:0px; height:100%;}
        body {
            font-family: 微软雅黑;

        }
        @media (min-width:576px) {
            .card-columns {
                orphans: 1;
                widows:1;
                -webkit-column-count: 4;
                -moz-column-count: 4;
                column-count: 4;
            }
        }

        @media (min-width:768px) {
            .card-columns {
                orphans: 1;
                widows: 1;
                -webkit-column-count: 4;
                -moz-column-count: 4;
                column-count: 4;
            }
        }

        @media (min-width:992px) {
            .card-columns {
                orphans: 1;
                widows: 1;
                -webkit-column-count: 5;
                -moz-column-count: 5;
                column-count: 5;
            }
        }

        @media (min-width:1200px) {
            .card-columns {
                orphans: 1;
                widows: 1;
                -webkit-column-count: 6;
                -moz-column-count: 6;
                column-count: 6;
            }
        }
        .card {
            padding: 1px;
        }
        span {
            color: #ff022a;
        }
        #form{
           /* padding-left: 176px;*/

            padding-left: 33%;
        }
        #form input{
            background-color: transparent;
            border:1px solid rgb(149, 145, 155);
            border-radius:3px;
          /*  height:20px;*/
            padding: 0.5%;
        }
        #reg-div input{
            background-color: transparent;
            border:1px solid rgb(152, 151, 154);
            border-radius:3px;
           /* height:20px;*/
        }
       #reg-div form{
           position: inherit;
         /*  margin-left: 140px;*/
           margin-left:25%;
           z-index: 2;
       }
 .bilil{
      position:inherit;
    /*  left: 0px;
      bottom: 0px;
     width: 150px;
     height: 150px;*/
     left: 0;
     bottom: 0;
     width:33%;
     height: 40%;
     z-index: 1;
  }
        .bilir{
            position:inherit;
          /*  right: 0px;
            bottom: 0px;
            width: 150px;
            height: 150px;*/
            right: 0;
            bottom: 0;
            width:33%;
            height:40%;
            z-index: 1;
        }
    </style>
    <script type="text/javascript">
        function loadXMLDoc() {
            var xmlhttp;
            var code = document.getElementById("code").value;
            var user = document.getElementById("user").value;
            var pass = document.getElementById("pass").value;
            if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
                xmlhttp = new XMLHttpRequest();
            }
            else {// code for IE6, IE5
                xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }
            xmlhttp.onreadystatechange = function () {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    var valid = xmlhttp.responseText;
                    if (valid == "1") {
                        document.getElementById("userV").innerHTML = "";
                        document.getElementById("passV").innerHTML = "";
                        var t=document.getElementById("codeV");

                        t.innerHTML = "error code";

                    }
                    else if (valid == "2") {
                        document.getElementById("userV").innerHTML = "User does not exist";
                        document.getElementById("passV").innerHTML = "";
                        document.getElementById("codeV").innerHTML = "";
                    }
                    else if (valid == "3") {
                        window.location.href = "/my";
                    }
                    else {
                        document.getElementById("passV").innerHTML = "password error";
                        document.getElementById("userV").innerHTML = "";
                        document.getElementById("codeV").innerHTML = "";
                    }

                }
            }
            xmlhttp.open("GET", "/check?user=" + user + "&pass=" + pass + "&code=" + code, true);
            xmlhttp.send();
        }

        function show(id) {
            if (id.id == "login") {
                document.getElementById("cover-div").style.display = "";
                document.getElementById("login-div").style.display = "";
            } else {
                document.getElementById("cover-div").style.display = "";
                document.getElementById("reg-div").style.display = "";

            }
        }
        function closed() {
            document.getElementById("cover-div").style.display = "none";
            document.getElementById("login-div").style.display = "none";
        }
        function regClosing() {
            document.getElementById("reg-div").style.display = "none";
            document.getElementById("cover-div").style.display = "none";


        }
        function reg() {

            var pass = document.getElementById("reg-pass").value;
            var passt = document.getElementById("reg-passt").value;
            if (!(pass == passt)) {
                document.getElementById("again").innerHTML = "password do not match";
            } else {
                var user = document.getElementById("reg-user").value;
                var postStr = "user=" + user + "&pass=" + pass + "&passt=" + passt;
                var ajax = false;
                if (window.XMLHttpRequest) {
                    ajax = new XMLHttpRequest();
                    if (ajax.overrideMimeType) {
                        ajax.overrideMimeType("text/xml");
                    }
                } else if (window.ActiveXObject) {
                    try {
                        ajax = new ActiveXObject("Msxml2.XMLHTTP");
                    } catch (e) {
                        try {
                            ajax = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {
                        }
                    }
                }
                if (!ajax) { // 异常，创建对象实例失败
                    window.alert("不能创建XMLHttpRequest对象实例.");
                    return false;
                }
                ajax.open("POST", "/reg", true);
                ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                //发送POST数据
                ajax.send(postStr);
                ajax.onreadystatechange = function () {
                    if (ajax.readyState == 4 && ajax.status == 200) {
                        var text = ajax.responseText;
                        if (text == "0") {
                            document.getElementById("again").innerHTML = "";
                            alert("this account has been registered");
                        }
                        else if (text == "1") {
                            document.getElementById("again").innerHTML = "";
                            alert("success");

                            document.getElementById("reg-div").style.display = "none";
                            document.getElementById("cover-div").style.display = "none";
                        }


                    }
                }
            }

        }
        function changebili1(i){

            var bilil=document.getElementById("bilil");
            var bilir=document.getElementById("bilir");
            if(i==1){
                bilil.src="/image/bilil2.png";
                bilir.src="/image/bilir2.png";

            }else{
                bilil.src="/image/bilil1.png";
                bilir.src="/image/bilir1.png";
            }
        }
        function changebili2(i){

            var bilill=document.getElementById("bilill");
            var bilirr=document.getElementById("bilirr");
            if(i==1){
                bilill.src="/image/bilil2.png";
                bilirr.src="/image/bilir2.png";

            }else{
                bilill.src="/image/bilil1.png";
                bilirr.src="/image/bilir1.png";
            }
        }
    </script>

</head>
<!--<body style="margin-left: 0px;margin-right: 0px;margin-top: 0px;">-->
<body style="margin-left: 0;margin-right: 0;margin-top: 0;">
<!--<div style="background-image: url(/image/onlineTrading.png);background-size:100% 100%;width: 100%;height: 430px;opacity: 0.9;text-align: center">-->
<div style="background-image: url(/image/onlineTrading.png);background-size:80% 100%;width:100%;height:35%;opacity: 0.9;text-align: center">
    <button class="bt" id="login" style="background-color:rgba(255, 30, 37, 0.60);color: white" onmouseover="this.style.backgroundColor='#ff1456'" onmouseout="this.style.backgroundColor='rgba(255, 30, 37, 0.60)'" onclick="show(this)">Login</button>
    &nbsp;
    <button class="bt" id="reg" style="color: white" onclick="show(this)">Register</button>
    <br><br><br><br><br><br><br>

    <form action="/search" method="post" style="height:12%;width:100%" >
    <!--   <input type="search"  name="search" value="找出你想要的" class="sc" style="width: 400px;color: white">-->
        <input type="search"  name="search" value="search items you want" class="sc" style="width:30%;color: white">
        <input type="submit"  value="Search" class="sc" style="width:3.5%;color: white">
    </form>

</div>
<hr>
<div class="container-fluid">
    <div class="row justify-content-center">
        <div class="col-8">
            <div class="card-columns" style="text-align: center">
                <c:forEach items="${types}" var="type">

                        <div class="card">
                            <a href="/typeItems?id=${type.id}">
                                <img class="card-img-top" src="${type.imgAdr}?rad=<%=System.currentTimeMillis()%>" alt="Card image cap">
                            </a>
                            <div class="card-footer">
                                <h5 class="card-title">${type.name}</h5>
                            </div>
                        </div>

                </c:forEach>
            </div>
        </div>
    </div>
</div>
<!-- <div id="cover-div" style="position: absolute;left: 0px;top: 0px;width: 100%;height:1000px;background-color: rgba(0, 0, 0, 0.4);display: none"></div>-->
<div id="cover-div" style="position: absolute;left: 0px;top: 0px;width: 100%;height:110%;background-color: rgba(0, 0, 0, 0.4);display: none">
</div>
<div id="login-div" class="smallWin" style="display: none"
     onmouseenter="document.getElementById('close').style.display='block'"
     onmouseleave="document.getElementById('close').style.display='none'">
    <!--<img src="/image/closing.png" class="img" style=" float: right;width: 30px;height: 30px; display: none;" id="close" onclick="closed()">-->
    <img src="/image/closing.png" class="img" style=" float: right;width:7%;height:10%; display: none;" id="close" onclick="closed()">
<img src="/image/bilil1.png" class="bilil"  id="bilil">
    <form action="/my" id="form">
        <label>Username</label>
        <small style="color: #ff3d00">default account 'admin'</small>
        <br><input type="text" id="user"><span id="userV"></span><br>
        <label>Password</label>
        <small style="color: #ff3d00">default password 'admin'</small>
        <input type="password" id="pass" onfocus="changebili1(1)" onblur="changebili1(2)"><span id="passV"></span><br>
        <label>Verification code</label><br><input type="text" id="code"><span id="codeV"></span><br>
        Click to change<br>
        <!--<img id="img" src="/ww?q=0" onclick="this.src='/ww?q='+Math.random()" style="width: 150px;height: 60px;border-radius: 3px;"><br>-->
        <img id="img" src="/ww?q=0" onclick="this.src='/ww?q='+Math.random()" style="width:58%;height:30%;border-radius: 3px;"><br><br/>

        <!--<input type="button" onclick="loadXMLDoc()" style="height:24px;font-size: 15px" value="登陆">-->
        <input type="button" onclick="loadXMLDoc()" style="height:15%;width:15%;font-size: 15px" value="Login">
 </form>
    <img src="/image/bilir1.png" class="bilir" id="bilir">
</div>
<div id="reg-div" class="smallWin" style="display: none" onmouseenter="document.getElementById('regC').style.display='block'" onmouseleave="document.getElementById('regC').style.display='none'">
   <!-- <img src="/image/closing.png" class="img" id="regC" style=" float: right;width: 30px; height: 30px; display: none;" onclick="regClose()"><br>-->
    <img src="/image/closing.png" class="img" id="regC" style=" float: right;width:7%; height:10%; display: none;"  onclick="regClosing()"><br>
    <img src="/image/bilil1.png" class="bilil" id="bilill">
    <script src="/js/angular.min.js"></script>
    <form ng-app="myApp" ng-controller="validateCtrl"
          name="myForm" method="post" novalidate>

        <p>Username<br>
            <input type="text" id="reg-user" name="user" ng-model="user" required>

            <span ng-show="myForm.user.$error.required">Username is necessary</span>

        </p>

        <p>Password<br>
            <input type="password" id="reg-pass" onfocus="changebili2(1)" onblur="changebili2(2)" name="pass" ng-model="pass" required>

            <span ng-show="myForm.pass.$error.required">Password is necessary</span>


        </p>

        <p>Confirm password<br>
            <input type="password" id="reg-passt" onfocus="changebili2(1)" onblur="changebili2(2)" name="passt" ng-model="passt" required>

            <span ng-show="myForm.passt.$error.required">Confirm again</span>

            <span id="again"/>

        </p>

        <p>
          <!--  <input type="button"
                   ng-disabled="myForm.user.$error.required||myForm.pass.$error.required||myForm.passt.$error.required"
                   value="注册" style="height:24px;font-size: 15px" onclick="reg()">-->
            <input type="button"
                   ng-disabled="myForm.user.$error.required||myForm.pass.$error.required||myForm.passt.$error.required"
                   value="Register" style="height:30%;font-size: 15px" onclick="reg()">
        </p>

    </form>

    <script>
        var app = angular.module('myApp', []);
        app.controller('validateCtrl', function ($scope) {

        });
    </script>
<img src="/image/bilir1.png" class="bilir" id="bilirr">
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
