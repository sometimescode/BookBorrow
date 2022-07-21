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

    <title>Registration</title>
    
    <s:head/>
  </head>

  <body>
    <div class="container">
      <div class="position-absolute top-50 start-50 translate-middle" style="width:50vh; height:100vh;">
        <div class="card text-center">
          <div class="card-header">
            Book Borrowing App
          </div>
          <div class="card-body">
            <s:form action="registerUser">
              <div class="form-floating mb-3">
                <s:textfield cssClass="form-control" id="floatingInput" name="userBean.username" placeholder="Username"/> 
                <label for="floatingInput">Username</label>
                <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="userBean.username" />
              </div>
              <div class="form-floating mb-3">
                <s:password cssClass="form-control" id="floatingPassword" name="userBean.password" placeholder="Password"/>
                <label for="floatingPassword">Password</label>
                <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="userBean.password" />
              </div>
              <div class="form-floating mb-3">
                <s:textfield cssClass="form-control" id="floatingFirstName" name="userBean.firstName" placeholder="First Name"/>
                <label for="floatingFirstName">First Name</label>
                <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="userBean.firstName" />
              </div>
              <div class="form-floating mb-3">
                <s:textfield cssClass="form-control" id="floatingLastName" name="userBean.lastName" placeholder="Last Name"/>
                <label for="floatingLastName">Last Name</label>
                <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="userBean.lastName" />
              </div>
              <div class="form-floating mb-3">
                <s:textfield cssClass="form-control" id="floatingEmail" name="userBean.email" placeholder="Email"/>
                <label for="floatingEmail">Email</label>
                <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="userBean.email" />
              </div>
              <div class="form-floating mb-3">
                <s:textfield cssClass="form-control" id="floatingContactNumber" name="userBean.contactNumber" placeholder="Contact Number"/>
                <label for="floatingContactNumber">Contact Number</label>
                <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="userBean.contactNumber" />
              </div>
              <s:if test="!validationString.isEmpty()">
                <p class="text-danger"><i class="bi bi-info-square-fill"></i> <s:property escapeHtml="false" value="validationString"/><p>
              </s:if> 
              <s:submit cssClass="btn btn-primary w-100" value="Register"/>
            </s:form>
          </div>
          <div class="card-footer text-muted">
            Already have an account? <a href="<s:url action='login'/>">Log in</a>
          </div>
        </div>    
      </div>
    </div>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>