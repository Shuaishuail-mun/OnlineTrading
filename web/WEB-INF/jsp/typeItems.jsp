<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/16
  Time: 10:24
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
  #back{
      position: absolute;
      right:40px;
     top:18px;
      width: 60px;
      height: 60px;
      opacity: 0.5;
      display: none;

  }
    #back:hover{
        opacity: 1;
    }
  </style>
    <script>
        function showBack(id){
            if(id.scrollTop>100){
              document.getElementById("back").style.display="block";
            }else{
                document.getElementById("back").style.display="none";
            }
        }
    </script>
</head>
<body style="width:70%;margin: auto">
<div class="container-fluid">
  <div class="row">
    <div class="col-12">
      <c:if test="${empty arrayList}">
        <br/>
        <br/>
        <br/>
        <br/>
        <div class="card text-center" style="border: none">
          <div class="card-body">
            <h5>There is no items in this category yet.</h5>
            <img src="/image/nothing-find.png" class="card-img" style="width: 500px;height: 500px" alt="...">
          </div>
        </div>
      </c:if>
      <div class="card-columns">
        <c:forEach items="${arrayList}" var="array">
          <a href="/displayItem?id=${array[0]}"><div class="card">
            <img src="/upload/${array[0]}1.png?rad=<%=System.currentTimeMillis()%>" class="card-img-top">
            <div class="card-body">
              <h5 class="card-title">CDN $: ${array[3]}</h5>
              <p class="card-text">${array[1]}<br><small>${array[2]}</small></p>
            </div>
            <div class="card-footer" style="text-align: center">
              <div class="star-rating">
                <div class="star-rating-top" style="width:<c:choose><c:when test="${array[4][1]==null}">0</c:when><c:otherwise>${Double.parseDouble(array[4][1])*20}</c:otherwise></c:choose>%">
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
              <small>${array[4][0]} payments</small>
            </div>
          </div></a></c:forEach>
      </div>
    </div>
  </div>
</div>
<img src="/image/back-top.png"  id="back" onclick="document.getElementById('inline-div').scrollTop=0;"/>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
