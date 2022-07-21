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

    <title>Profile</title>

    <style>
      .book-cover {
        width:148px;
        height:200px;
      }

      table a {
        text-decoration: none;
      }
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

          <div class="card my-4">
            <h5 class="card-header">Currently Borrowing</h5>
            <div class="card-body">
              <div class="row row-cols-1 row-cols-md-3 g-4">
                <s:iterator value="checkedOutBooks" status="checkedOutBooksStatus">
    
                  <s:url action="book" namespace="/" var="urlTag" >
                    <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                  </s:url>
    
                  <div class="col">
                    <div class="card border d-flex align-items-center">
                      <div class="card-header w-100">
                        <s:property value="joinBookEntryTitle"/>
                      </div>
                      <div class="card-body">
                        <s:if test="joinBookEntryCover != null">
                          <s:a href="%{urlTag}"><img src="data:image/jpeg;base64,${joinBookEntryCover}" class="card-img-top img-fluid book-cover" alt="${title}"></s:a>
                        </s:if>
                      </div>
                      <div class="card-footer w-100">
                        <small class="text-muted">
                          <p>
                            Copy Serial ID: <s:property value="joinBookCopySerialId"/> <br/>
                            Expected Return Date: <s:property value="expectedReturnDate"/>
                          </p>
                        </small>
                      </div>
                    </div>
                  </div>
                </s:iterator>
              </div>
            </div>
          </div>
 
          <hr>

          <div class="card my-4">
            <h5 class="card-header">Pending Checkout Requests</h5>
            <div class="card-body">
              <div class="row row-cols-1 row-cols-md-3 g-4">
                <s:iterator value="pendingCheckoutRequests" status="pendingCheckoutRequestsStatus">
    
                  <s:url action="book" namespace="/" var="urlTag" >
                    <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                  </s:url>
                  <s:url action="cancelPendingCheckoutRequest" namespace="/user" var="cancelPendingTag" >
                    <s:param name="checkoutRequestId"><s:property value="dbId"/></s:param>
                  </s:url>
    
                  <div class="col">
                    <div class="card border d-flex align-items-center">
                      <div class="card-header w-100">
                        <s:property value="joinBookEntryTitle"/>
                      </div>
                      <div class="card-body">
                        <s:if test="joinBookEntryCover != null">
                          <s:a href="%{urlTag}"><img src="data:image/jpeg;base64,${joinBookEntryCover}" class="card-img-top img-fluid book-cover" alt="${title}"></s:a>
                        </s:if>
                      </div>
                      <div class="card-footer w-100">
                        <small class="text-muted">
                          <!-- Button trigger modal -->
                          <button type="button" class="w-100 btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop" data-bs-shref="${cancelPendingTag}">
                            Cancel Checkout Request
                          </button>
                        </small>
                      </div>
                    </div>
                  </div>
                </s:iterator>
              </div>
            </div>
          </div>

          <hr>
      
          <div class="card my-4">
            <h5 class="card-header">Approved For Checkout</h5>
            <div class="card-body">
              <div class="row row-cols-1 row-cols-md-3 g-4">
                <s:iterator value="approvedCheckoutRequests" status="approvedCheckoutRequestsStatus">
    
                  <s:url action="book" namespace="/" var="urlTag" >
                    <s:param name="ISBN"><s:property value="joinBookEntryISBN"/></s:param>
                  </s:url>
                  <s:url action="cancelApprovedCheckoutRequest" namespace="/user" var="cancelApprovedTag" >
                    <s:param name="checkoutRequestId"><s:property value="dbId"/></s:param>
                    <s:param name="bookCopyId"><s:property value="requestedCopyId"/></s:param>
                  </s:url>
    
                  <div class="col">
                    <div class="card border d-flex align-items-center">
                      <div class="card-header w-100">
                        <s:property value="joinBookEntryTitle"/>
                      </div>
                      <div class="card-body">
                        <s:if test="joinBookEntryCover != null">
                          <s:a href="%{urlTag}"><img src="data:image/jpeg;base64,${joinBookEntryCover}" class="card-img-top img-fluid book-cover" alt="${title}"></s:a>
                        </s:if>
                      </div>
                      <div class="card-footer w-100">
                        <small class="text-muted">
                          <p>
                            Copy Serial ID: <s:property value="joinBookCopySerialId"/> <br/>
                            <!-- Button trigger modal -->
                            <button type="button" class="w-100 btn btn-danger" data-bs-toggle="modal" data-bs-target="#staticBackdrop" data-bs-shref="${cancelApprovedTag}">
                              Cancel Checkout Request
                            </button>
                          </p>
                        </small>
                      </div>
                    </div>
                  </div>
                </s:iterator>
              </div>
            </div>
          </div>

          <hr> 

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
    
    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Confirm Checkout Request Cancellation</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <div class="modal-body">
            Are you sure you want to cancel this request?
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            <s:a id="modalCancelCheckoutRequestTarget" href="#" cssClass="btn btn-primary">Yes, I'm sure.</s:a>
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

      var confirmationModal = document.getElementById('staticBackdrop')
      confirmationModal.addEventListener('show.bs.modal', function (event) {
        // Button that triggered the modal
        var button = event.relatedTarget
        // Extract info from data-bs-* attributes
        var path = button.getAttribute('data-bs-shref')

        var link = document.getElementById("modalCancelCheckoutRequestTarget");
        link.setAttribute("href", path);

      })
    </script>
  </body>
</html>