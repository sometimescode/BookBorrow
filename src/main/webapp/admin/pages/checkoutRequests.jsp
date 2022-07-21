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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.0/font/bootstrap-icons.css">

    <!-- Datatables CSS -->
    <link href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css" rel="stylesheet">

    <link rel="stylesheet" href="../css/general.css">

    <title>Admin</title>

    <sj:head/>

    <style>
      table a {
        text-decoration: none;
      }
    </style>
  </head>
  <body class="admin">
    <s:include value="adminMenu.jsp" />

    <div class="container">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">
          <h1>Online Checkout Requests</h1>

          <div class="card my-4">
            <h5 class="card-header">Pending Requests</h5>
            <div class="card-body">
              <div class="table-responsive">
                <table id="pendingCheckoutRequests" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Book</th>
                      <th>Requester</th>
                      <th>Request Date</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <s:iterator value="pendingCheckoutRequests" status="pendingCheckoutRequestsStatus">
                      <s:url action="book" namespace="/" var="urlTag" >
                        <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                      </s:url>
                      <s:url action="userView" namespace="/admin/user" var="userTag" >
                        <s:param name="userId"><s:property value="requesterId"/></s:param>
                      </s:url>
                      <s:url action="checkoutRequestForm" namespace="/admin/checkout" var="assessAjaxTag" >
                        <s:param name="checkoutRequestId"><s:property value="dbId"/></s:param>
                      </s:url>
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:a href="%{userTag}"><s:property value="joinAccountLastName"/>, <s:property value="joinAccountFirstName"/></s:a></td>
                        <td><s:property value="requestDate"/></td>
                        <td>
                          <sj:a id="assessAjax%{#pendingCheckoutRequestsStatus.count}"
                          cssClass="btn btn-success"
                          href="%{assessAjaxTag}"
                          targets="result"
                          indicator="indicator"
                          data-bs-toggle="modal" 
                          data-bs-target="#staticBackdrop"
                          >Action</sj:a>
                        </td>
                      </tr>
                    </s:iterator>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <div class="card mb-4">
            <h5 class="card-header">Requests Ready for Checkout</h5>
            <div class="card-body">
              <div class="table-responsive">
                <table id="approvedCheckoutRequests" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Book</th>
                      <th>Requester</th>
                      <th>Approval Date</th>
                      <th>Copy Serial Id</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <s:iterator value="approvedCheckoutRequests" status="approvedCheckoutRequestsStatus">
                      <s:url action="book" namespace="/" var="urlTag" >
                        <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                      </s:url>
                      <s:url action="userView" namespace="/admin/user" var="userTag" >
                        <s:param name="userId"><s:property value="requesterId"/></s:param>
                      </s:url>
                      <s:url action="checkoutRecordForm" namespace="/admin/checkout" var="checkoutAjaxTag" >
                        <s:param name="checkoutRequestId"><s:property value="dbId"/></s:param>
                      </s:url>
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:a href="%{userTag}"><s:property value="joinAccountLastName"/>, <s:property value="joinAccountFirstName"/></s:a></td>
                        <td><s:property value="statusUpdateDate"/></td>
                        <td><s:property value="joinBookCopySerialId"/></td>
                        <td>
                          <sj:a id="checkoutAjax%{#readyForCheckoutCheckoutRequestsStatus.count}"
                          cssClass="btn btn-primary w-100"
                          href="%{checkoutAjaxTag}"
                          targets="result"
                          indicator="indicator"
                          data-bs-toggle="modal" 
                          data-bs-target="#staticBackdrop"
                          >Create Checkout Record</sj:a>
                        </td>
                      </tr>
                    </s:iterator>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
 
          <div class="card mb-4">
            <h5 class="card-header">All Checkout Requests</h5>
            <div class="card-body">
              <div class="table-responsive">
                <table id="allCheckoutRequests" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Book</th>
                      <th>Requester</th>
                      <th>Request Date</th>
                      <th>Status</th>
                      <th>Status Update Date</th>
                      <th>Copy Serial Id</th>
                      <th>Checkout Record</th>
                    </tr>
                  </thead>
                  <tbody>
                    <s:iterator value="allCheckoutRequests" status="allCheckoutRequestsStatus">
                      <s:url action="book" namespace="/" var="urlTag" >
                        <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                      </s:url>
                      <s:url action="userView" namespace="/admin/user" var="userTag" >
                        <s:param name="userId"><s:property value="requesterId"/></s:param>
                      </s:url>
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:a href="%{userTag}"><s:property value="joinAccountLastName"/>, <s:property value="joinAccountFirstName"/></s:a></td>
                        <td><s:property value="requestDate"/></td>
                        <td><s:property value="status"/></td>
                        <td><s:property value="statusUpdateDate"/></td>
                        <td><s:property value="joinBookCopySerialId"/></td>
                        <td>
                          <s:if test="joinCheckoutRecordId != 0">
                            <s:property value="joinCheckoutRecordId"/>
                          </s:if>
                          <s:else>
                            N/A
                          </s:else>
                        </td>
                      </tr>
                    </s:iterator>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

            <!-- <s:property value="%{#pendingCheckoutRequestsStatus.count}" />
            Title: <s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a>
            Requester Id: <s:a href="%{userTag}"><s:property value="joinAccountLastName"/>, <s:property value="joinAccountFirstName"/></s:a>
            Status: <s:property value="status"/>
            Request Date: <s:property value="requestDate"/>
            Approval Date: <s:property value="statusUpdateDate"/>
            <s:if test="checkoutRecordId == 0">
              Action: <s:a href="%{checkoutRecordTag}">Create Checkout Record</s:a>
            </s:if>
            <s:else>
              Checkout Record Id: <s:property value="checkoutRecordId"/>
            </s:else> -->
        </div>
      </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Assess Checkout Request</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            <div class="text-center">
              <img id="indicator" src="../images/Blocks-1s-200px.gif" alt="Loading..." style="display:none"/> 
            </div>
 
            <div id="result">

            </div>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
          </div>
        </div>
      </div>
    </div>

    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
    
    <!-- Jquery -->
    <!-- Conflicts with Struts2 JQUERY Plugin, so it's removed on pages that use that plugin -->

    <!-- Datatables -->
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>

    <script>
      $(document).ready(function () {
        $('table.display').DataTable({
          order: [[0, 'desc']],
        });
      });

      var myModalEl = document.getElementById('staticBackdrop')
      myModalEl.addEventListener('hidden.bs.modal', function (event) {
        $("#result").empty();
      })
    </script>
  </body>
</html>