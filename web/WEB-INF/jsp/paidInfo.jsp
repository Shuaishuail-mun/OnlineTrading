<%--
  Created by IntelliJ IDEA.
  User: liutao
  Date: 2015/9/15
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title></title>
  <style>
    .record{
      font-family: 微软雅黑;
      font-size: 1.1em;
      padding: 20px;
      width: 70%;
    }
  </style>
</head>
<body>
<div class="record">
订单号:<br><br>${obj[1]}<br><br>
收货人电话:<br><br>${obj[2]}<br><br>
收货人地址:<br><br>${obj[3]}<br><br>
订单日期:<br><br>${obj[0]}
  </div>
</body>
</html>
