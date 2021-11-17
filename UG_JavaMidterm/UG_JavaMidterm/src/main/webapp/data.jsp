<%@ page import="com.example.ug_javamidterm.Product" %>
<%@ page import="com.example.ug_javamidterm.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Product</title>
    <style>
        label {
            width:100px;
            display: inline-block;
        }

        input {
            width: 200px;
        }
    </style>
</head>
<body>

<h1>Add Vacancy</h1>

<form method="post">
    <label>Title:</label><input id="productTitle" type="text" name="title"><br/>
    <label>Barcode:</label><input id="productBarcode" type="text" name="barcode"><br/>
    <label>Price:</label><input id="productPrice" type="number" name="price" value="0.00" step=".01"><br/>
    <label>Amount:</label><input id="productAmount" type="number" name="amount" value="0"><br/>
    <button type="submit">Check</button>
</form>

<%
    Product product = new Product();

    if(request.getParameter("title") != null
            && request.getParameter("barcode") != null
            && request.getParameter("price") != null
            && request.getParameter("amount") != null) {

        product.setTitle(request.getParameter("title"));
        product.setBarcode(request.getParameter("barcode"));
        product.setPrice(Float.parseFloat(request.getParameter("price")));
        product.setAmount(Integer.parseInt(request.getParameter("amount")));


        session.setAttribute("title", product.getTitle());
        session.setAttribute("barcode", product.getBarcode());
        session.setAttribute("price", product.getPrice());
        session.setAttribute("amount", product.getAmount());

%>
<script>window.location.href = "check.jsp";</script>
<%
    }
%>

</body>
</html>
