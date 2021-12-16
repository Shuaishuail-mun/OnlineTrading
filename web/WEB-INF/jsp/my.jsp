<%@ page import="tian.table.User" %>
<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/1
  Time: 21:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<% User user = (User) session.getAttribute("user");%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
    <style>
     * {
         font-family: 微软雅黑;
     }
     body{
         margin:0;
         padding:0;
     }
    </style>
</head>
<!--<body style="margin:0px">-->
<body>
<nav class="sticky-top navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="/myIndex" target="section">Home <span class="sr-only">(current)</span></a>
            </li>
            <c:if test="${user.userType==2}">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        Manage Departments
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                        <a class="dropdown-item" href="/addTypePage" target="section">Add</a>
                        <a class="dropdown-item" href="/delTypePage" target="section">Delete</a>
                    </div>
                </li>
            </c:if>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Sell goods
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                    <a class="dropdown-item" href="/sell" target="section">Post goods</a>
                    <a class="dropdown-item" href="/mySell?ok=''" target="section">Goods sold</a>
                    <a class="dropdown-item" href="/handOut" target="section">To be distributed</a>
                    <a class="dropdown-item" href="/sellerChat" target="section">Messages</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/displayCert" target="section">&nbsp;&nbsp;<img src="/image/shoppingCart.svg"></a>
            </li>
            <li class="nav-item"><a class="nav-link" href="/itemPaid" target="section">Orders</a></li>
        </ul>
        <ul class="navbar-nav mr-right">
            <li class="nav-item"><a class="nav-link">Welcome! ${user.name}</a></li>
            <li class="nav-item"><a class="nav-link" href="/getEditInfo" target="section">Edit info</a></li>
            <li class="nav-item"><a class="nav-link" href="/index">Logout</a></li>
        </ul>
        <form action="/search" method="post" target="section" class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" name="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>&nbsp;&nbsp;
    </div>
</nav>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script>
    function setIframeHeight(iframe) {
        if (iframe) {
            var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
            if (iframeWin.document.body) {
                iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
            }
        }
    };

    window.onload = function () {
        setIframeHeight(document.getElementById('myiframe'));
    };
</script>
<iframe src="/myIndex" name="section" style="width: 100%;" id="myiframe" scrolling="no" frameborder="0"/>
<!--<iframe src="/myIndex" name="section"
        style="position:relative;left:0;top:0;border:none;width: 100%;height:95%;margin-top:0;padding:0;z-index:1"/>-->
</body>
</html>
