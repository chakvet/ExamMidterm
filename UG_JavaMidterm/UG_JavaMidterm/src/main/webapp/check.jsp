<%@ page import="com.example.ug_javamidterm.Product" %>
<%@ page import="javax.persistence.EntityManagerFactory" %>
<%@ page import="javax.persistence.Persistence" %>
<%@ page import="javax.persistence.EntityManager" %>
<%@ page import="javax.persistence.EntityTransaction" %>
<%@ page import="com.example.ug_javamidterm.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Review Information</title>
</head>
<body>
<h3>Review Information</h3>

<ul>
    <li>
        <p>Title : <%= session.getAttribute("title")%>
        </p>
    </li>
    <li>
        <p>Barcode : <%= session.getAttribute("barcode")%>
        </p>
    </li>
    <li>
        <p>Price : <%= session.getAttribute("price")%>
        </p>
    </li>
    <li>
        <p>Amount : <%= session.getAttribute("amount")%>
        </p>
    </li>
</ul>

<form action="check.jsp" method="post">
    <input type="hidden" name="shouldSave" value="yes"/>
    <input type="submit" value="Save">
</form>

<% String isSuccessful = "no"; %>

<%

    if(     session.getAttribute("title") != null
            && session.getAttribute("barcode") != null
            && session.getAttribute("price") != null
            && session.getAttribute("amount") != null
            && request.getParameter("shouldSave") != null
            && request.getParameter("shouldSave").equals("yes")) {


        EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("default");

        EntityManager entityManager = entityManagerFactory.createEntityManager();

        EntityTransaction entityTransaction = entityManager.getTransaction();

        try {
            entityTransaction.begin();

            Product product = new Product();

            product.setTitle(session.getAttribute("title").toString());
            product.setBarcode(session.getAttribute("barcode").toString());
            product.setPrice(Float.parseFloat(session.getAttribute("price").toString()));
            product.setAmount(Integer.parseInt(session.getAttribute("amount").toString()));

            entityManager.persist(product);

            entityTransaction.commit();

            isSuccessful = "yes";

        } finally {
            if (entityTransaction.isActive()) {
                entityTransaction.rollback();
            }
            entityManager.close();
            entityManagerFactory.close();
        }


        if(isSuccessful.equals("yes")) { %>

            <form id="finalForm" action="index.jsp" method="post">
                <input type="hidden" name="is_successful" value="<%= isSuccessful %>">
            </form>
            <script>
                document.getElementById("finalForm").submit();
            </script>
<%
        }
    }
%>
</body>
</html>
