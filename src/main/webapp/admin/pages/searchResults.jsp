<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.0/font/bootstrap-icons.css">

    <link rel="stylesheet" href="../css/general.css">

    <title>Admin - Search Book</title>

    <style>
      .book-cover {
        width:148px;
        height:200px;
      }
    </style>
  </head>
  <body class="admin">
    <s:include value="adminMenu.jsp" />

    <div class="container">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">

          <h2>Search Results for "<s:property value="queryTitle"/>"</h2>
          <div class="row row-cols-1 row-cols-md-3 g-4">
            <s:iterator value="resultBooks" status="resultBooksStatus">
              <div class="col">
                <div class="card border d-flex align-items-center p-4">
                  <s:url action="getBookEntryByISBN" namespace="/admin/book" var="urlTag" >
                    <s:param name="ISBN"><s:property value="ISBN"/></s:param>
                  </s:url>
                  <s:if test="cover != null">
                    <s:a href="%{urlTag}"><img src="data:image/jpeg;base64,${cover}" class="card-img-top img-fluid book-cover" alt="${title}"></s:a>
                  </s:if>
                </div>
                <div class="card-footer">
                  <small class="text-muted">
                    <div class="text-start"><s:property value="ISBN"/></div>
                    <div class="text-start"><s:property value="title"/></div>
                    <div class="text-end">by <s:property value="authors"/></div>
                  </small>
                </div>
              </div>
            </s:iterator>
          </div>

        </div>
      </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>