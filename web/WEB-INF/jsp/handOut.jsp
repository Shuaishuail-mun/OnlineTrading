<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/15
  Time: 22:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title></title>
  <style>
    body{
      font-family: 微软雅黑;
    }
    .rec-div{
      margin: 0px auto;
      width: 60%;
      height:193px;
      border-top: 1px rgba(120, 117, 123, 0.95) solid;

      /*border-radius:10px;*/
      padding-left: 10px;
    }
    .rec-div button{
      background-color: transparent;
      font-family: 微软雅黑;
      font-size: 15px;
      border: 1px solid rgba(179, 182, 183, 0.86);
      border-radius: 2px;
    }
    .rec-div img{
      width: 150px;
      height: 150px;
      float: left;
    }
  </style>
  <script>
    function handOut(id){
      var record=id.value;
      var xmlhttp;
      if (window.XMLHttpRequest){// code for IE7+, Firefox, Chrome, Opera, Safari
        xmlhttp = new XMLHttpRequest();
      }
      else {// code for IE6, IE5
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      }
      xmlhttp.onreadystatechange = function () {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
          var valid = xmlhttp.responseText;
          if(valid=="ok"){
            alert("Successfully delivered");
            location.reload();
          }

        }
      };
      var s="record="+record;
      xmlhttp.open("POST","/handSure", true);
      xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
      xmlhttp.send(s);
    }

  </script>
</head>
<body>
<c:forEach items="${arrayList}" var="array">


<div class="rec-div">
  <br>
  <a href="/displayItem?id=${array[2]}"><img src="/upload/${array[2]}1.png?rad=<%=System.currentTimeMillis()%>"></a>
  ${array[0]}<br>
  ${array[5][0]}<br>
  ${array[5][1]}*${array[6]}<br>
  Phone number: ${array[3]}<br>
  Address: ${array[4]}<br>
  Order number: ${array[7]}<br>
  <button value="${array[1]}" onclick="handOut(this)">Delivery</button>
</div>
</c:forEach>


</body>
</html>
