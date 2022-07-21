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
    
    <link rel="stylesheet" href="http://localhost:8080/app/css/general.css">

    <title>Admin - User Profile View</title>

    <style>
      table a {
        text-decoration: none;
      }
    </style>
  </head>
  <body class="profile">
    <s:include value="../../pages/adminMenu.jsp" />

    <div class="container">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">

          <h1>User Details</h1>
          <div class="row">
            <div class="col-sm-12 col-md-8">
              <div class="p-4">
                <div class="row">
                  <div class="col-3">
                    First Name:
                  </div>
                  <div class="col-9">
                    <s:property value="userBean.firstName"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Last Name:
                  </div>
                  <div class="col-9">
                    <s:property value="userBean.lastName"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Email: 
                  </div>
                  <div class="col-9">
                    <s:property value="userBean.email"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Contact Number:
                  </div>
                  <div class="col-9">
                    <s:property value="userBean.contactNumber"/>
                  </div>
                </div>
              </div>
            </div>
          </div>
        
          <div class="card my-4">
            <h5 class="card-header">Checkout Requests</h5>
            <div class="card-body">
              <div class="table-responsive">
                <table id="checkoutRequests" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>Title</th>
                      <th>Request Date</th>
                      <th>Status</th>
                      <th>Status Update Date</th>
                      <th>Copy Serial Id</th>
                      <th>Checkout Record</th>
                    </tr>
                  </thead>
                  <tbody>
                    <s:iterator value="onlineCheckoutRequests" status="onlineCheckoutRequestsStatus">
                      <s:url action="book" namespace="/" var="urlTag" >
                        <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                      </s:url>
      
                      <tr>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:property value="requestDate"/></td>
                        <td><s:property value="status"/></td>
                        <td><s:property value="statusUpdateDate"/></td>
                        <td><s:property value="joinBookCopySerialId"/></td>
                        <td>              
                          <s:if test="joinCheckoutRecordId != 0">
                            <a class="crId" crId="${joinCheckoutRecordId}" href="#allCheckoutRecords">View</a>
                          </s:if>
                          <s:else>
                            N/A
                          </s:else>
                        </td>
                      </tr>
                    </s:iterator>
                  </tbody>
                  <tfoot>
                      <tr>
                        <th>Title</th>
                        <th>Request Date</th>
                        <th>Status</th>
                        <th>Status Update Date</th>
                        <th>Copy Serial Id</th>
                        <th>Checkout Record</th>
                      </tr>
                  </tfoot>
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
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:a href="%{urlTag}"><s:property value="joinBookEntryTitle"/></s:a></td>
                        <td><s:property value="bookCopyId"/></td>
                        <td><s:property value="checkoutDate"/></td>
                        <td><s:property value="expectedReturnDate"/></td>
                        <td><s:property value="actualReturnDate"/></td>
                        <td><s:property value="status"/></td>
                      </tr>
                    </s:iterator>
                  </tbody>
                  <tfoot>
                    <tr>
                      <th class="searchable">ID</th>
                    </tr>
                  </tfoot>
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
        $('a.crId').click(function(e) {
          e.preventDefault(); 
          var url = location.href;            
          location.href = "#allCheckoutRecords";
          $("#crTableID").val(e.target.getAttribute("crId")) 
          $( "#crTableID" ).keyup();
          $( "#crTableID" ).focus();
          return false; 
        });

        // Setup - add a text input to each footer cell
        $('#allCheckoutRecords tfoot th.searchable').each(function () {
            var title = $(this).text();
            $(this).html('<input id ="crTable' + title + '" class="form-control" type="text" placeholder="Search" />');
        });

        $('#checkoutRequests').DataTable({
          order: [[4, 'desc']],
        });
        $('#allCheckoutRecords').DataTable({
          order: [[0, 'desc']],
          initComplete: function () {
            // Apply the search
            this.api()
                .columns(0)
                .every(function () {
                    var that = this;

                    $('input', this.footer()).on('keyup change clear', function () {
                        if (that.search() !== this.value) {
                            that.search(this.value).draw();
                        }
                    });
                });
          },
          createdRow: function( row, data, dataIndex, cells ) {
            var actualReturnDate = new Date(data[5]);
            var expectedReturnDate = new Date(data[4]);
            if ( expectedReturnDate.getTime() < actualReturnDate.getTime() ) {
              $(cells[5]).addClass( 'text-danger' );
            }
          }
        });
      });
    </script>
  </body>
</html>