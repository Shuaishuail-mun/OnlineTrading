<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Online Trading</title>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
</head>

<body class="container" style="width:60%; margin:auto; padding-top: 10%;">
<!--<div  style="background-color: rgba(255, 31, 238, 0.12);width: 60%;margin: 15px auto;height: 600px;">
  <br><center>
  <form method="post" action="/addType" enctype="multipart/form-data">
    <p style="font-family: 黑体;"><b>商品分类：</b><input type="text"  name="typeName"  /><br><br></p>
    <a href="javascript:; " class="file">选择文件 <input type="file" class="file"  name="typeImg" />&nbsp;</a>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <input type="submit" class="btn"  value="添加" />
  </form>
  <div style="margin: 0px auto">
    <img src="${src}" style="width: 400px;height: 400px;border: dashed;"/>
  </div></center>
</div>-->
<div class="row justify-content-center">
  <form method="post" action="/addType" enctype="multipart/form-data" class="col-6">
    <div class="form-group">
      <label for="typeName">Department Name</label>
      <input type="text" class="form-control" name="typeName">
      <small id="nameHelp" class="form-text text-muted">Input the name of the new department</small>
    </div>
    <div class="input-group">
      <div class="custom-file">
        <input type="file" class="custom-file-input" name="typeImg" aria-describedby="inputGroupFileAddon01">
        <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
      </div>
    </div>
    <small class="form-text text-muted">Upload picture for the new department</small><br>
    <button type="submit" class="btn btn-primary">Add</button>
  </form>
</div>
<br>
<c:if test="${not empty src}">
  <div class="row justify-content-center">
    <div class="col-6 alert alert-success" role="alert">
      Adding a new department successfully!
    </div>
  </div>
</c:if>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>
