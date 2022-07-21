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
    
    <!-- Datatables CSS -->
    <link href="https://cdn.datatables.net/1.12.1/css/jquery.dataTables.min.css" rel="stylesheet">

    <link rel="stylesheet" href="../css/general.css">

    <title>Admin</title>

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

          <h1>Admin Dashboard</h1>

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
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:a href="%{userTag}"><s:property value="joinAccountLastName"/>, <s:property value="joinAccountFirstName"/></s:a></td>
                        <td><s:property value="requestDate"/></td>
                      </tr>
                    </s:iterator>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
          
          <div class="card my-4">
            <h5 class="card-header">Expected Check-Ins (Today and Late)</h5>
            <div class="card-body">
              <div class="table-responsive">
                <table id="expectedCheckins" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Title</th>
                      <th>Copy ID</th>
                      <th>Borrower</th>
                      <th>Checkout Date</th>
                      <th>Expected Return Date</th>
                    </tr>
                  </thead>
                  <tbody>
                    <s:iterator value="expectedCheckins" status="expectedCheckinsStatus">
                      <s:url action="book" namespace="/" var="urlTag" >
                          <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                      </s:url>
                      <s:url action="userView" namespace="/admin/user" var="userTag" >
                        <s:param name="userId"><s:property value="borrowerId"/></s:param>
                      </s:url>
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:property value="bookCopyId"/></td>
                        <td><s:a href="%{userTag}"><s:property value="joinAccountLastName"/>, <s:property value="joinAccountFirstName"/></s:a></td>
                        <td><s:property value="checkoutDate"/></td>
                        <td><s:property value="expectedReturnDate"/></td>
                      </tr>
                    </s:iterator>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        
    <!-- Jquery -->
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>

    <!-- Datatables -->
    <script src="https://cdn.datatables.net/1.12.1/js/jquery.dataTables.min.js"></script>

    <script>
      $(document).ready(function () {
        $('#pendingCheckoutRequests').DataTable({
          order: [[0, 'desc']],
        });

        $('#expectedCheckins').DataTable({
          order: [[0, 'desc']],
          "createdRow": function( row, data, dataIndex, cells ) {
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            var expectedReturnDate = new Date(data[5]);
            if ( expectedReturnDate.getTime() < today.getTime() ) {
              $(cells[5]).addClass( 'text-danger' );
              $(cells[6].getElementsByTagName("a")).addClass( 'btn-danger' );
            } else {
              $(cells[6].getElementsByTagName("a")).addClass( 'btn-primary' );
            }
          }
        });
      });
    </script>

  </body>
</html>