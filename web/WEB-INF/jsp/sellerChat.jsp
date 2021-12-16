<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/16
  Time: 21:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
        body {
            font-family: 微软雅黑;
            width: 80%;
            margin: auto;
            font-size: 1.2em;
        }

        #chat {
            border: none;
            display: none;
        }
        .list-group {
            width: 60%;
            margin-left: 30%;
        }

        .input-group {
            font-family: 微软雅黑;
            width: 90%;
            margin-left: 5%;
            border: 1px solid #bcc0c2;
        }
        #chat img {
            position: inherit;
            right: 0px;
            top: 0px;
            width: 30px;
            height: 30px;
        }

        #chatK {
            width: 90%;
            margin-left: 5%;
            height: 500px;
            overflow-y: scroll;
            border: 1px solid #e0e0e0;
        }

        #chatK div{
            padding-bottom:13px;
        }
        #chatK div span{
            width: auto;
            height: auto;
            background:transparent;
            color: #000000;
        }

    </style>
</head>

<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-6">
            <ul class="list-group">
                <c:forEach items="${objects}" var="obj" varStatus="loop">
                    <li id="${obj[1]}" onclick="chatting(this)" class="list-group-item d-flex justify-content-between align-items-center">
                            ${obj[0]}
                        <span class="badge badge-primary badge-pill">${numbers[loop.count - 1]}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
        <div class="col-6">
            <div id="chat">
                <img src="/image/closing.png" onclick="closed(this)">

                <div id="chatK">

                </div>
                <div class="input-group">
                    <input type="text" class="form-control" id="sendText"/>
                    <div class="input-group-append">
                        <button onclick="sending()" class="btn btn-primary">Send</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    var chat = document.getElementById("chat");
    var chatK = document.getElementById("chatK");
    var sendText = document.getElementById("sendText");
    var tempId;
    var flag = false;
    var intervalFlag;
    function chatting(id) {
        if (!flag) {
            tempId = id.id;
            chat.style.display = "block";
            flag = true;
            intervalFlag = setInterval(catchC, 2000);
        }
    }
    function closed(id) {
        document.getElementById("chatK").innerHTML = "";
        id.parentNode.style.display = "none";
        clearInterval(intervalFlag);
        flag = false;
    }
    function catchC() {
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
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
                        chatK.appendChild(newDiv);
                    }
                }

            }
        };
        var str = "id=" + tempId;
        xmlhttp.open("POST", "/selRece?rad=" + Math.random(), true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(str);
    }
    function sending() {
        var xmlhttp;
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        var newDiv = document.createElement("div");
        newDiv.align = "right";
      //  newDiv.innerHTML = "我:<br>" + sendText.value;
        var lit=document.createElement("span");
        lit.innerHTML=sendText.value;
        var newImg=document.createElement("img");
        newImg.src="/image/mzl2.png";

        newImg.style.float="right";
        newDiv.appendChild(newImg);
        newDiv.appendChild(lit);
        chatK.appendChild(newDiv);
        var str = "id=" + tempId + "&content=" + sendText.value;
        xmlhttp.open("POST", "/selSend", true);
        xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        xmlhttp.send(str);
    }
</script>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
