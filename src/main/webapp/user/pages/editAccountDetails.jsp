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

    <link rel="stylesheet" href="http://localhost:8080/app/css/general.css">

    <title>Profile</title>

    <style>
    </style>
  </head>
  <body class="profile">
    <s:include value="../../pages/menu.jsp" />

    <div class="container">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">

          <div class="d-flex flex-row-reverse">
            <div class="p-2 bd-highlight"><a class="float-end btn btn-primary" href="<s:url action='viewAccount' namespace='/user'/>">View Account Details</a></div>
          </div>
          
          <hr>

          <h1>Edit Account Details</h1>
          <s:form action="editAccount">
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
            <s:submit cssClass="btn btn-primary w-100" value="Edit"/>
          </s:form>
      
        </div>
      </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>