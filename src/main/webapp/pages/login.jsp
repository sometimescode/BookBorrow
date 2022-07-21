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

    <link rel="stylesheet" href="css/general.css">

    <title>Log in</title>
    
    <s:head/>
  </head>

  <body>
    <div class="container">
      <div class="position-absolute top-50 start-50 translate-middle" style="width:50vh">
        <div class="card text-center">
          <div class="card-header">
            Book Borrowing App
          </div>
          <div class="card-body">
            <s:form action="loginAccount">
              <div class="form-floating mb-3">
                <s:textfield cssClass="form-control" id="floatingInput" name="accountBean.username" placeholder="Username"/> 
                <label for="floatingInput">Username</label>
                <s:fielderror cssClass="text-danger" fieldName="accountBean.username" />
              </div>
              <div class="form-floating mb-3">
                <s:password cssClass="form-control" id="floatingPassword" name="accountBean.password" placeholder="Password"/>
                <label for="floatingPassword">Password</label>
                <s:fielderror cssClass="text-danger" fieldName="accountBean.password" />
              </div>
              <s:if test="!validationString.isEmpty()">
                <p class="text-danger"><i class="bi bi-info-square-fill"></i> <s:property escapeHtml="false" value="validationString"/><p>
              </s:if> 
              <s:submit cssClass="btn btn-primary w-100" value="Log in"/>
            </s:form>
          </div>
          <div class="card-footer text-muted">
            Don't have an account? <a href="<s:url action='register'/>">Register</a>
          </div>
        </div>    
      </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>