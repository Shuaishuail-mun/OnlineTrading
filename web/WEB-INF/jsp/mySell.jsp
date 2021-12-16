<%@ page import="tian.table.User" %>
<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/6
  Time: 10:38
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<% User user=(User)session.getAttribute("user");%>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <style>
        img {
            max-width: 200px;
        }
    </style>
</head>
<body style="width: 80%; margin: auto">
<c:if test="${ok}"><script>alert("Successfully deleted");</script></c:if>
<br><br>
<div class="container-fluid">
    <div class="row">
        <div class="col-4">
            <div class="list-group" id="list-tab" role="tablist">
                <c:forEach items="${items}" var="item" varStatus="status">
                    <a class="list-group-item list-group-item-action <c:if test="${status.first}">active</c:if>" id="list-${item[0]}" data-toggle="list" href="#tab-${item[0]}" role="tab">${item[1]} $${item[2]}</a>
                </c:forEach>
            </div>
        </div>
        <div class="col-8">
            <div class="tab-content" id="nav-tabContent">
                <c:forEach items="${items}" var="item" varStatus="status">
                    <div class="tab-pane fade show <c:if test="${status.first}">active</c:if>" id="tab-${item[0]}" role="tabpanel">
                        <div class="card">
                            <img class="card-img-top" src="/upload/${item[0]}1.png?rad=<%=System.currentTimeMillis()%>" alt="Card image cap">
                            <div class="card-body">
                                <h5 class="card-title">${item[1]}</h5>
                                <p class="card-text">${item[2]}</p>
                                <a href="/sellItem?id=${item[0]}&ok=''" class="btn btn-primary">Modify</a>
                                <a href="/deleteItem?id=${item[0]}" class="btn btn-secondary">Delete</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</body>
</html>
