<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/4
  Time: 14:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title></title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <style>
    @media (min-width:576px) {
      .card-columns {
        column-count: 2;
      }
    }

    @media (min-width:768px) {
      .card-columns {
        column-count: 3;
      }
    }

    @media (min-width:992px) {
      .card-columns {
        column-count: 4;
      }
    }

    @media (min-width:1200px) {
      .card-columns {
        column-count: 5;
      }
    }
    .card-columns .card{
    }
    body{
      font-family:微软雅黑;
      font-size: 16px;
      color: #8d8d8d;
    }
    .ig{
      border-radius: 8px;

      width: 180px;
      height: 100px;
      -webkit-filter: blur(2px); /* Chrome, Opera */
      -moz-filter: blur(2px);
    }
    .big-div{
      position: relative;
      float: left;
      padding-left:37px;
      padding-top: 8px;
      padding-bottom: 16px;


    }
    .big-div div{

      position: absolute;
      left:50px;
      width: 150px;
      top: 42px;
      text-align: center;
      font-family:微软雅黑;
      font-size: 23px;
      color: #ffffff;
      font-weight:400;
    }
    .big-div div:hover{
      color: #282e2f;

    }
    .ig:hover{
      -webkit-filter: blur(0px);
    }
    hr.split-department {
      padding: 0;
      border: none;
      border-top:solid rgba(143, 143, 143, 0.78);
      border-width: 1px;
      color: #333;
      text-align: center;
    }
    hr.split-department:after {
      content: "Departments";
      display: inline-block;
      position: relative;
      top: -0.7em;
      font-size: 1.2em;
      padding: 0 0.25em;
      background: white;
    }
    hr.split-newly {
      padding: 0;
      border: none;
      border-top:solid rgba(143, 143, 143, 0.78);
      border-width: 1px;
      color: #333;
      text-align: center;
    }
    hr.split-newly:after {
      content: "Newly posted";
      display: inline-block;
      position: relative;
      top: -0.7em;
      font-size: 1.2em;
      padding: 0 0.25em;
      background: white;
    }
    .card{
      padding-left: 1px;
      padding-right: 1px;
      padding-top: 1px;
      color: #282e2f;
    }
    .star-rating {
      unicode-bidi: bidi-override;
      color: #ddd;
      font-size: 0;
      height: 25px;
      margin: 0 auto;
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
  </style>
</head>
<body style="width: 75%; margin: auto">
<div class="container-fluid">
<div class="row">
  <div class="col-12">
    <hr class="split-department"><br>
  </div>
</div>
<div class="row">
  <div class="col-12">
    <c:forEach items="${types}" var="type">
      <div class="big-div">
        <a href="/typeItems?id=${type.id}"><img src="${type.imgAdr}?rad=<%=System.currentTimeMillis()%>" class="ig"></a>
        <div>${type.name}</div>
      </div>
    </c:forEach>
  </div>
</div>
<div class="row">
  <div class="col-12">
    <hr class="split-newly"><br>
  </div>
</div>
<div class="row">
  <div class="col-12">
    <div class="card-columns">
      <c:forEach items="${items}" var="item">
        <a href="/displayItem?id=${item.id}"><div class="card">
          <img src="/upload/${item.id}1.png?rad=<%=System.currentTimeMillis()%>" class="card-img-top">
          <div class="card-body">
            <h5 class="card-title">CDN $: ${item.price}</h5>
            <p class="card-text">${item.name}<br><small>${item.keyWord}</small></p>
          </div>
          <div class="card-footer" style="text-align: center;">
            <div class="star-rating">
              <div class="star-rating-top" style="width:<c:choose><c:when test="${item.star=='null'}">0</c:when><c:otherwise>${item.getStar()*20}</c:otherwise></c:choose>%">
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
            <small>${item.getSales()} payments</small>
          </div>
        </div></a></c:forEach>
    </div>
  </div>
</div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
