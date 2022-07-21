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
          <h1>Checkout Records</h1>

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
                      <th>Action</th>
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
                      <s:url action="checkinCheckoutRecord" namespace="/admin/checkin" var="checkinTag" >
                        <s:param name="checkoutRecordId"><s:property value="dbId"/></s:param>
                        <s:param name="bookCopyId"><s:property value="bookCopyId"/></s:param>
                      </s:url>
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:property value="bookCopyId"/></td>
                        <td><s:a href="%{userTag}"><s:property value="joinAccountLastName"/>, <s:property value="joinAccountFirstName"/></s:a></td>
                        <td><s:property value="checkoutDate"/></td>
                        <td><s:property value="expectedReturnDate"/></td>
                        <td>
                          <s:a cssClass="btn" href="%{checkinTag}">Check In</s:a>
                        </td>
                      </tr>
                    </s:iterator>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <div class="card my-4">
            <h5 class="card-header">Upcoming Check-Ins</h5>
            <div class="card-body">
              <div class="table-responsive">
                <table id="laterExpectedCheckins" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Title</th>
                      <th>Copy ID</th>
                      <th>Borrower</th>
                      <th>Checkout Date</th>
                      <th>Expected Return Date</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <s:iterator value="laterExpectedCheckins" status="laterExpectedCheckinsStatus">
                      <s:url action="book" namespace="/" var="urlTag" >
                          <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                      </s:url>
                      <s:url action="userView" namespace="/admin/user" var="userTag" >
                        <s:param name="userId"><s:property value="borrowerId"/></s:param>
                      </s:url>
                      <s:url action="checkinCheckoutRecord" namespace="/admin/checkin" var="checkinTag" >
                        <s:param name="checkoutRecordId"><s:property value="dbId"/></s:param>
                        <s:param name="bookCopyId"><s:property value="bookCopyId"/></s:param>
                      </s:url>
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:property value="bookCopyId"/></td>
                        <td><s:a href="%{userTag}"><s:property value="joinAccountLastName"/>, <s:property value="joinAccountFirstName"/></s:a></td>
                        <td><s:property value="checkoutDate"/></td>
                        <td><s:property value="expectedReturnDate"/></td>
                        <td>
                          <s:a cssClass="btn btn-secondary" href="%{checkinTag}">Check In</s:a>
                        </td>
                      </tr>
                    </s:iterator>
                  </tbody>
                </table>
              </div>
            </div>
          </div>

          <div class="card mb-4">
            <h5 class="card-header">Checkout Records</h5>
            <div class="card-body">
              <div class="table-responsive">
                <table id="allCheckoutRecords" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>ID</th>
                      <th>Title</th>
                      <th>Copy ID</th>
                      <th>Borrower</th>
                      <th>Checkout Date</th>
                      <th>Expected Return Date</th>
                      <th>Actual Return Date</th>
                      <th>Status</th>
                    </tr>
                  </thead>
                  <tbody>
                    <s:iterator value="allCheckoutRecords" status="allCheckoutRecordsStatus">
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
                        <td><s:property value="actualReturnDate"/></td>
                        <td><s:property value="status"/></td>
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

        $('#laterExpectedCheckins').DataTable({
          order: [[5, 'asc']],
        });

        $('#allCheckoutRecords').dataTable( {
          order: [[6, 'desc']],
          "createdRow": function( row, data, dataIndex, cells ) {
            var actualReturnDate = new Date(data[6]);
            var expectedReturnDate = new Date(data[5]);
            if ( expectedReturnDate.getTime() < actualReturnDate.getTime() ) {
              $(cells[6]).addClass( 'text-danger' );
            }
          }
        } );
      });

      // "createdRow": function( row, data, dataIndex ) {
      //       var date1 = new Date();
      //       date1.setHours(0, 0, 0, 0);
      //       var date2 = new Date(data[5]);

      //       if ( date2.getTime() == date1.getTime() ) {
      //         $(row).addClass( 'border border-warning' );
      //       }
      //     }
    </script>
  </body>
</html>