<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/15
  Time: 9:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title></title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
  <style>
    body{
      width: 80%;
      margin: auto;
      font-family: 微软雅黑;
    }

    a{
      text-decoration:none;
      color: black;
    }

    .left-div{
      padding-top: 3%;
    }

    .left-div div{
      width:99.5%;
    }
    .left-div div img{
      max-height: 110px;
      width: 110px;
      float: left;
    }
    #big-div{
      width:100%;

    }
    #comment{
      position:absolute;
      left: 33%;
      top: 10%;
      width: 34%;
      border: 1px solid #ffffff;
      border-radius: 8px;
      background-color: #ececec;
      display: none;
      padding: 10px;

    }
    #comment .img{
      position:inherit;
      right: 0px;
      top: 0px;
      width: 30px;
      height: 30px;
    }

    #comment input{
      background-color: transparent;
      font-family: 微软雅黑;
      border:1px solid rgba(159, 154, 160, 0.65);
      border-radius: 2px;
      width: 80%;
      height: 35px;
    }

  </style>
  <script>
    var xmlhttp;
    if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
      xmlhttp = new XMLHttpRequest();
    }
    else {// code for IE6, IE5
      xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
   /* xmlhttp.onreadystatechange = function () {
      if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
        var valid = xmlhttp.responseText;
        if(valid=="ok"){
          alert("删除成功!");
          location.reload();
        }

      }
    };*/
    function paying(id){
      var record=id.parentNode.id;
      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          var valid = xmlhttp.responseText;
          if(valid=="ok"){
            alert("Successfully paid");
            location.reload();
          }

        }
      };
      var s="record="+record;
      xmlhttp.open("POST","/doneToPaid", true);
      xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xmlhttp.send(s);


    }
    function deling(id){
      var record=id.parentNode.id;
      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          var valid = xmlhttp.responseText;
          if(valid=="ok"){
            location.reload();
          }

        }
      };
      var s="record="+record;
      xmlhttp.open("POST","/deleteDone", true);
      xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xmlhttp.send(s);


    }


    var whichC;
    function showC(id){
      document.getElementById("big-div").style.display="block";
      document.getElementById("comment").style.display="block";
      whichC=id.parentNode.id;

    }
    function closeC(){
      document.getElementById("big-div").style.display="none";
      document.getElementById("comment").style.display="none";
    }
    var countStar=0;
    function star(id){
      var src=id.src;
      if(src.match("wstar.png")){
        id.src="/image/ostar.png";
        countStar++;
      }else{
        id.src="/image/wstar.png";
        countStar--;
      }

    }
    function comming(){
      var comm=document.getElementById("mycomm").value;

      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          var valid = xmlhttp.responseText;
          if(valid=="ok"){
            alert("Successfully submitted");
            location.reload();
          }

        }
      };
      var s="record="+whichC+"&count="+countStar+"&comm="+comm;
      xmlhttp.open("POST","/commDone", true);
      xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xmlhttp.send(s);

    }
    function changeModal(order, phone, address, date) {
      let modal = document.getElementById("changeModal");
      let lists = modal.getElementsByTagName("span");
      for (let i = 0; i < lists.length; i++) {
        let list = lists[i];
        list.innerText = arguments[i];
      }
    }
  </script>
</head>
<body>
<div class="container-fluid">
  <div class="row justify-content-center">
    <div class="col-8">
      <div class="left-div">
        <c:forEach items="${arrayList}" var="array">
          <div id="${array[2][4]}">
            <a href="/displayItem?id=${array[3]}"><img src="/upload/${array[3]}1.png?rad=<%=System.currentTimeMillis()%>"></a>
              ${array[0]}<br>
              ${array[1]}<br>
              ${array[5][0]}<br>
              ${array[5][1]}*${array[6]}<br>
            <c:choose>
              <c:when test="${array[4]==0}"><button class="btn btn-outline-primary" onclick="paying(this)">Pay</button>&nbsp;<button class="btn btn-outline-dark" onclick="deling(this)">Delete</button></c:when>
              <c:otherwise>
                <c:if test="${array[7]==0}"><button class="btn btn-outline-secondary" onclick="showC(this)">Comment</button></c:if>
              </c:otherwise>
            </c:choose>
            <button class="btn btn-outline-info" data-toggle="modal" data-target="#orderInfo" onclick="changeModal('${array[2][1]}', '${array[2][2]}', '${array[2][3]}', '${array[2][0]}')">Check order</button>
          </div>
          <br>
          <hr>
        </c:forEach>
      </div>
    </div>
  </div>
</div>
<div id="big-div">
  <div id="comment">
    <img class="img" src="/image/closing.png" onclick="closeC()">
    <h5>Rating</h5>
    <img src="/image/wstar.png" onmouseover="star(this)">
    <img src="/image/wstar.png" onmouseover="star(this)">
    <img src="/image/wstar.png" onmouseover="star(this)">
    <img src="/image/wstar.png" onmouseover="star(this)">
    <img src="/image/wstar.png" onmouseover="star(this)"><br>
    <h5>Comment</h5>
    <input type="text" id="mycomm"><br><br>

    <button class="btn btn-outline-dark" onclick="comming()">Submit</button>


  </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<div class="modal fade" id="orderInfo" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLongTitle">Modal title</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body" id="changeModal">
        Order number: <span id="modal-order"></span><br>
        Phone number: <span id="modal-phone"></span><br>
        Address:      <span id="modal-address"></span><br>
        Date:         <span id="modal-date"></span><br>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
</body>
</html>
