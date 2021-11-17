<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
</head>
<body>
<h1>All Product</h1>

<% if(request.getParameter("is_successful") != null &&
        request.getParameter("is_successful").equals("yes")) { %>
<p>Information written into DB successfully!</p>
<% } %>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                   url = "jdbc:mysql://localhost/ug_db"
                   user = "root"  password = "12345" />

<!-- catch block is needed because otherwise -->
<!-- app doesn't run before table is created -->
<c:catch var ="dbException">
    <sql:query dataSource = "${snapshot}" var = "result">
        SELECT * from PRODUCTS;
    </sql:query>
</c:catch>

<table border="1" width="100%">

    <tr>
        <th>ID</th>
        <th>Title</th>
        <th>Barcode</th>
        <th>Price</th>
        <th>Amount</th>
    </tr>

    <c:forEach var="row" items="${result.rows}">
        <tr>
            <td><c:out value="${row.id}" /></td>
            <td><c:out value="${row.title}" /></td>
            <td><c:out value="${row.barcode}" /></td>
            <td>$<c:out value="${row.price}" /></td>
            <td><c:out value="${row.amount}" /></td>
        </tr>
    </c:forEach>

</table>

<a style="display: inline-block;
    border: 1px solid black;
    margin: 10px;
    padding: 10px;
    border-radius: 10px;
    background-color: green;
    color: white;
    text-decoration: none;"
   href="data.jsp">Add New</a>

</body>
</html>