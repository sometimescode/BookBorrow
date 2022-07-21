<!doctype html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

    <title>Add Checkout Record</title>
    
  </head>
  <body>
    Create Checkout Record for Checkout Request ID <span class="fw-bold"><s:property value="checkoutRequestId"/></span>

    <hr>

    <s:form action="addCheckoutRecord">
      <div class="form-floating mb-3">
        <sj:datepicker cssClass="form-control" placeholder="Published Date" id="floatingExpectedReturnDate" name="checkoutRecordBean.expectedReturnDate" showOn="focus"/>
        <label for="floatingExpectedReturnDate">Expected Return Date</label>
        <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="checkoutRecordBean.expectedReturnDate" />
      </div>
      <s:textfield name="checkoutRecordBean.bookEntryId" hidden="true"/>
      <s:textfield name="checkoutRecordBean.borrowerId" hidden="true"/>
      <s:textfield name="checkoutRecordBean.onlineCheckoutRequestId" hidden="true"/>
      <s:textfield name="checkoutRecordBean.bookCopyId" hidden="true"/>
      <s:submit cssClass="btn btn-primary w-100" value="Create"/>
    </s:form>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>