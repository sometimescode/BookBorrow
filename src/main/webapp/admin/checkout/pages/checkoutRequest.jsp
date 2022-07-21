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

    <title>Action Checkout Request</title>
    
  </head>
  <body>
    <!-- Create Checkout Record for Checkout Request ID <span class="fw-bold"><s:property value="checkoutRequestId"/></span>

    <hr> -->
    
    <s:if test="bookCopySelectList.size() == 0">
      <s:form action="rejectCheckoutRequest">
        There are currently no more available copies.
        <s:textfield name="checkoutRequestId" hidden="true"/>
        <s:submit cssClass="btn btn-danger w-100" value="Reject"/>
      </s:form>
    </s:if>
    <s:else>
      <s:form action="approveCheckoutRequest">
        <div class="form-floating mb-3">
          <s:select cssClass="form-control form-select" id="floatingBookCopyId" name="checkoutRequestBean.requestedCopyId" placeholder="Requested Copy Id" list="bookCopySelectList"/>
          <label for="floatingBookCopyId">Select Book Copy to Reserve</label>
          <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="checkoutRequestBean.requestedCopyId" />
        </div>
        <s:textfield name="checkoutRequestId" hidden="true"/>
        <s:submit cssClass="btn btn-primary w-100" value="Approve"/>
      </s:form>
    </s:else>

    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>