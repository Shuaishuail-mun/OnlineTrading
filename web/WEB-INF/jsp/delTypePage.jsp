<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/17
  Time: 15:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title></title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>
<script>
  function dele(id){
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
        if(valid="ok"){
          location.reload();
        }

      }
    };
    var s="id="+id.id;
    xmlhttp.open("POST","/delType", true);
    xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    xmlhttp.send(s);
  }
</script>
<body class="container" style="width: 60%;margin: auto; padding-top: 2%">
<div class="row justify-content-center">
    <div class="col-4">
        <div class="list-group" id="list-tab" role="tablist">
            <c:forEach items="${types}" var="type" varStatus="status">
                <a class="list-group-item list-group-item-action <c:if test="${status.first}">active</c:if>" id="${type.id}-list" data-toggle="list" href="#tab-${type.id}" role="tab">
                        ${type.name}
                </a>
            </c:forEach>
        </div>
    </div>
    <div class="col-8">
        <div class="tab-content" id="nav-tabContent">
            <c:forEach items="${types}" var="type" varStatus="status">
                <div class="tab-pane fade show <c:if test="${status.first}">active</c:if>" id="tab-${type.id}" role="tabpanel">
                    <div class="card" style="width: 18rem;">
                        <img src="${type.imgAdr}?rad=<%=System.currentTimeMillis()%>" class="card-img-top" alt="Delete">
                        <div class="card-body">
                            <button type="button" class="btn btn-secondary" id="${type.id}" onclick="dele(this)">Delete</button>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
