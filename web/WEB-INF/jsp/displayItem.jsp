<%@ page import="tian.table.User" %>
<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/9
  Time: 0:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<% User user = (User) session.getAttribute("user");%>
<html>
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        .star-rating {
            unicode-bidi: bidi-override;
            color: #ddd;
            font-size: 0;
            height: 25px;
            margin-left: 0;
            position: relative;
            display: table;
            padding: 0;
            text-shadow: 0px 1px 0 #a2a2a2;
        }

        .star-rating span {
            padding: 5px;
            font-size: 20px;
        }

        .star-rating span:after {
            content: "★";
        }
        .star-rating-top {
            color: #FFD700;
            padding: 0;
            position: absolute;
            z-index: 1;
            display: block;
            top: 0;
            left: 0;
            overflow: hidden;
            white-space: nowrap;
        }

        .star-rating-bottom {
            padding: 0;
            display: block;
            z-index: 0;
        }
        body {
        }
        #showBig {
            width: 580px;
            height: 580px;
        }

        #close {
            width: 30px;
            height: 30px;
            position: inherit;
            right: 0px;
            top: 0px;
            display: none;
        }

        #showBigDiv {
            position: absolute;
            left: 324px;
            top: 15px;

            display: none;

        }

        #show {
            height: 800px;
        }

        #img1 {

        }

        #img2 {
            width: 400px;
            height: 400px;
            position: absolute;
            overflow: hidden;
            display: none;
            z-index: 100;
        }

        #img_big {
            height: 1600px;
            position: absolute;
        }

        #img3 {
            background-color: rgba(0, 0, 0, 0.4);
            width: 200px;
            height: 200px;
            position: absolute;
            display: none;
        }

        .ig {
            width: 50px;
            height: 50px;
        }

        button {

        }

        button:hover {
            background-color: rgba(255, 255, 255, 0.48);
        }

        hr {
            border: 0;
            background-color: rgb(241, 241, 241);
            height: 1px;
        }

        .close {
            width: 30px;
            height: 30px;
            position: inherit;
            right: 0px;
            top: 0px;
            display: none;
        }

        #record {
            position: absolute;
            left: 37%;
            top: 10%;
            width: 26%;
            height: 430px;
            padding: 1%;
            border: 1px solid rgba(0,0,0,.075);
            background-color: #e9ecef;
            display: none;
            color: #495057;
        }

        #chat {
            position: absolute;
            left: 30%;
            width: 40%;
            top: 7%;
            padding: 5px;
            border: 1px solid #faf3ff;
            border-radius: 5px;
            background-color: rgba(229, 229, 229, 0.9);
            display: none;

        }

        #chat .input-group {
            margin-left: 2%;
            width: 96%;
        }

        #chat button {
        }

        #chat img {
            position: inherit;
            right: 0px;
            top: 0px;
            width: 30px;
            height: 30px;
        }

        #chatK {
            width: 100%;
            height: 400px;
            overflow-y: scroll;
            color: black;

        }
    #chatK div{
        padding-bottom:13px;
    }
        #chatK div span{
           width: auto;
            height: auto;
           background-color:transparent;
            color: #000000;
        }


    </style>
    <script src="/js/jquery-1.11.3.js" type="text/javascript"></script>
    <script type="text/javascript">
        window.onload = function() {
            window.parent.scrollTo(0,0);
        }
    </script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-5 justify-content-end">
            <div style="position: relative">
                <div id="img1">
                    <img src="/upload/${item.id}1.png?rad=<%=System.currentTimeMillis()%>" id="show">
                </div>
                <div id="img2">
                    <img src="/upload/${item.id}1.png?rad=<%=System.currentTimeMillis()%>" id="img_big">
                </div>
                <div id="img3"></div>
            </div>
        </div>
        <div class="col-1 justify-content-start"><br>
            <c:forEach begin="1" end="${item.imageNum}" step="1" var="number">
                <img src="/upload/${item.id}${number}.png?rad=<%=System.currentTimeMillis()%>"
                     style="border:1px solid #767676;border-radius: 3px;padding: 1px" class="ig" onmouseover="change(this)"  onclick="displayImg(document.getElementById('show'))"><br><br>
            </c:forEach>
        </div>
        <div class="col-6 justify-content-center">
            <br>
            <div>
                <h5>${item.name}</h5>
                <p>${item.keyWord}<br><small>${item.description}</small></p>
                <h5>Ratings (${com[0]})</h5>
                <div class="star-rating">
                    <div class="star-rating-top" style="width:<c:choose><c:when test="${com[1]==null}">0</c:when><c:otherwise>${Double.parseDouble(com[1])*20}</c:otherwise></c:choose>%">
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                    <div class="star-rating-bottom">
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                        <span></span>
                    </div>
                </div>
                <h5>Price</h5>
                $ <button class="btn btn-outline-info" id="priceShow">${arrayList.get(0)[1]}</button>
                <h5>Options</h5>
                <div id="select">
                    <c:forEach items="${arrayList}" var="array">
                        <button class="btn btn-outline-info" value="${array[1]}" <c:if
                                test="${arrayList.get(0)==array}"> style="border: 2px solid rgba(46, 161, 255, 0.87);"</c:if>
                                onclick="selected(this)">${array[0]}</button>
                        &nbsp;
                    </c:forEach>
                </div>
                <h5>Count</h5>
                <button name="minus" id="minus" disabled="disabled" onclick="numChange(this)">-</button>
                <button id="num">1</button>
                <button onclick="numChange(this)">+</button>
                <br><br>
                <button class="btn btn-outline-secondary" value="${item.id}"
                        <c:choose>
                            <c:when test="${user!=null}">onclick="joinCert(this)"</c:when>
                            <c:otherwise>onclick="login()"</c:otherwise>
                        </c:choose>>Shopping cart
                </button>
                &nbsp;&nbsp;
                <button class="btn btn-outline-primary"
                        <c:choose>
                            <c:when test="${user!=null}"> onclick="document.getElementById('record').style.display='block'"</c:when>
                            <c:otherwise>onclick="login()"</c:otherwise>
                        </c:choose>
                >Order now
                </button>
                &nbsp;&nbsp;
                <button class="btn btn-outline-dark" <c:choose>
                    <c:when test="${user!=null}"> onclick="openC()"</c:when>
                    <c:otherwise>onclick="login()"</c:otherwise>
                </c:choose>>Contact
                </button>
                <img src="/image/chat.png?rad=<%=System.currentTimeMillis()%>" style="width: 27px;height:25px;"/>
                <button id="sendTo" style="opacity: 0">${item.userId}</button>

            </div>
        </div>
    </div>
    <div class="row justify-content-end">
        <div class="col-6">
            <h4>Comments</h4><br><br>
            <c:forEach items="${comm}" var="c">
                <hr>
                ${c[0]}<br>
                <c:forEach begin="1" end="${c[1]}" step="1">
                    <img src="/image/ostar.png?rad=<%=System.currentTimeMillis()%>"/>
                </c:forEach>
                <br>
                ${c[2]}<br>
            </c:forEach>

        </div>
    </div>
</div>
<br>
<div id="showBigDiv" onmouseenter="document.getElementById('close').style.display='block'"
     onmouseleave="document.getElementById('close').style.display='none'">
    <img src="/image/closing.png" id="close" onclick="document.getElementById('showBigDiv').style.display='none'">
    <img src="" id="showBig"/>
</div>
<div id="chat">
    <img src="/image/closing.png" onclick="cloC(this)"/><br>

    <div id="chatK">

    </div>
    <div class="input-group mb-3">
        <input type="text" class="form-control" id="se">
        <div class="input-group-append">
            <button class="btn btn-outline-secondary" type="button" onclick="sendings()">Send</button>
        </div>
    </div>
</div>
<div id="record" onmouseenter="this.firstElementChild.style.display='block'"
     onmouseleave="this.firstElementChild.style.display=''">
    <img src="/image/closing.png" class="close" onclick="document.getElementById('record').style.display=''"><br>
    <script src="/js/angular.min.js"></script>
    <form method="post" ng-app="myApp" ng-controller="validateCtrl" name="myForm" novalidate>
        <div class="form-group">
            <label>${item.name} / <span id="record-select">${arrayList.get(0)[0]}</span> / <span id="record-price">${arrayList.get(0)[1]}</span>*<span id="record-num">1</span></label>
        </div>
        <div class="form-group">
            <label>Phone number</label>
            <input type="text" class="form-control" id="telephone" name="telephone" ng-model="telephone" required>
            <small class="form-text text-muted" ng-show="myForm.telephone.$error.required">This area is required</small>
        </div>
        <div class="form-group">
            <label>Address</label>
            <input type="text" class="form-control" id="address" name="address" ng-model="address" required>
            <small class="form-text text-muted" ng-show="myForm.address.$error.required">This area is required</small>
        </div>
        <input type="button" class="btn btn-primary" value="Pay" onclick="changeState()"
               ng-disabled="myForm.address.$error.required||myForm.telephone.$error.required"/>
        <input type="button" class="btn btn-secondary" onclick="buy()" value="Confirm"
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
<script>

    var select = "${arrayList.get(0)[0]}";
    var price = "${arrayList.get(0)[1]}";
    var recordState = 0;
    function changeState() {
        recordState = 1;
    }


    function sendings() {
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }

        var chatK = document.getElementById("chatK");
        var sendText = document.getElementById("se");
        var he = document.getElementById("sendTo").innerHTML;
        var newDiv = document.createElement("div");
        newDiv.align = "right";
        // newDiv.innerHTML =sendText.value;
        var lit=document.createElement("span");
        lit.innerHTML=sendText.value;
        var newImg=document.createElement("img");
        newImg.src="/image/mzl2.png";
     //  newImg.style.position="inherit";
     //   newImg.style.top="1px";
     //  newImg.style.right="0px";
        newImg.style.float="right";
        newDiv.appendChild(newImg);
        newDiv.appendChild(lit);

        chatK.appendChild(newDiv);

        var s = "he=" + he + "&text=" + sendText.value;
        xmlhttp.open("POST", "/sendText", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(s);
    }
    function deg() {
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }

        var chatK = document.getElementById("chatK");

        var he = document.getElementById("sendTo").innerHTML;
        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var back = xmlhttp.responseText;
                if (back != "0") {
                    var str = back.split("-");
                    for (var i = 0; i < str.length - 1; i++) {
                        var newDiv = document.createElement("div");

                        //newDiv.innerHTML = "他:<br>" + str[i];
                       var newImg=document.createElement("img");
                      newImg.src="/image/mzl.png";
                        newImg.style.float="left";
                        newDiv.appendChild(newImg);
                       var little=document.createElement("span");
                      little.innerHTML=str[i];
                        newDiv.appendChild(little);

                       // chatK.appendChild(newDiv);

                       // newDiv.align = "right";

                       // newDiv.innerHTML =str[i];
                      //  var newImg=document.createElement("img");
                       // newImg.src="/image/comstar.png";

                        chatK.appendChild(newDiv);
                    }
                }

            }
        };
        var str = "he=" + he;
        xmlhttp.open("POST", "/degFeed?rad=" + Math.random(), true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(str);
    }
    var intervalFlag;
    function openC() {

        document.getElementById("chat").style.display = "block";

        intervalFlag = setInterval(deg, 2000);
    }
    function cloC(id) {
        id.parentNode.style.display = "none";
        clearInterval(intervalFlag);
    }
    function buy() {
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }

        var number = document.getElementById("num").innerHTML;
        var tele = document.getElementById("telephone").value;
        var addr = document.getElementById("address").value;

        xmlhttp.onreadystatechange = function () {
            if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                var valid = xmlhttp.responseText;
                if (valid == "ok") {
                    alert("success");
                    document.getElementById("record").style.display = "none";
                }

            }
        };

        var str = "tele=" + tele + "&addr=" + addr + "&select=" + select + "&price=" + price + "&number=" + number + "&recordState=" + recordState + "&itemId=" +${item.id};
        xmlhttp.open("POST", "/buy", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(str);
    }
    function joinCert(id) {
        var itemId = id.value;
        var number = document.getElementById("num").innerHTML;
        var url = "/shoppingCert";
        var postStr = "?itemId=" + itemId + "&select=" + select + "&price=" + price + "&number=" + number;
        var ajax = false;
        if (window.XMLHttpRequest) { //Mozilla 浏览器
            ajax = new XMLHttpRequest();
            if (ajax.overrideMimeType) {//设置MiME类别
                ajax.overrideMimeType("text/xml");
            }
        }
        else if (window.ActiveXObject) { // IE浏览器
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
        //通过Post方式打开连接
        ajax.open("GET", url + postStr, true);

        ajax.send();
        //获取执行状态
        ajax.onreadystatechange = function () {
            //如果执行状态成功，那么就把返回信息写到指定的层里
            if (ajax.readyState == 4 && ajax.status == 200)
                if (ajax.responseText == "ok") {
                    alert("success");
                }

        }
    }
    function numChange(id) {
        var num = document.getElementById("num");
        var valu = parseInt(num.innerHTML);
        if (id.name == "minus") {
            if (valu > 1) {
                valu--;
                num.innerHTML = valu + "";
                document.getElementById("record-num").innerHTML = valu + "";
                if (valu == 1) {
                    id.disabled = "disabled";
                }
            }
        }
        else {
            valu++;
            num.innerHTML = "" + valu;
            document.getElementById("record-num").innerHTML = valu + "";
            document.getElementById("minus").disabled = false;
        }
    }
    function selected(id) {

        document.getElementById("select").firstElementChild.style.border = "1px solid #bbc0c1";
        document.getElementById("priceShow").innerHTML = id.value;
        select = id.innerHTML;
        price = id.value;
        document.getElementById("record-select").innerHTML = select;
        document.getElementById("record-price").innerHTML = price;
    }
    function change(id) {
        document.getElementById("show").src = id.src;
        document.getElementById("img_big").src = id.src;
        var a = document.getElementById("big-div").getElementsByTagName("img");
        for (var i = 0; i < a.length; i++) {
            a[i].style.border = "none";
        }
        id.style.border = "1px solid #767676";
     //   displayImg(document.getElementById("show"));

    }
    function displayImg(id) {

        document.getElementById("showBig").src = id.src;
        document.getElementById("showBigDiv").style.display = "block";
    }
    $(function () {
        var count = 0;
        $("#img1").mousemove(function (e) {

            var img2 = $("#img2");

            var img3 = $("#img3");
            img2.show();
            img3.show();
            var xScale = $("#img_big").width() / $("#show").width();
            var yScale = $("#img_big").height() / $("#show").height();
            var img3L = e.pageX - img3.width() / 2;
            var img3R = e.pageY - img3.height() / 2;
            var minLeft = $(this).offset().left;
            var minTop = $(this).offset().top;
            if (img3L <= minLeft) {
                img3L = minLeft;
            }
            else if (img3L >= (minLeft + $(this).width() - img3.width())) {
                img3L = minLeft + $(this).width() - img3.width();
            }
            if (img3R <= minTop) {
                img3R = minTop;
            }
            else if (img3R >= (minTop + $(this).height() - img3.height())) {
                img3R = minTop + $(this).height() - img3.height();
            }
            img3.css("left", img3L).css("top", img3R);
            img2.css("left", img3L + img3.width()).css("top", img3R + img3.height());
            img3.appendTo($("#img1"));
            $("#img_big").css("left", -(img3L - $("#img1").offset().left) * xScale).css("top", -(img3R - $("#img1").offset().top) * yScale);

        });
        $("#img1").mouseleave(function () {
            $("#img2").hide();
            $("#img3").hide();
        });
    });
    function login() {
        alert("Login first");
        this.location.href = "/index";

    }
</script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
