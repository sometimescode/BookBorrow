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

    <link rel="stylesheet" href="../../css/general.css">

    <title>Admin - Book Information</title>

    <style>
      .book-details-cover {
        width: 100%;
      }
    </style>
  </head>
  <body class="admin">
    <s:include value="../../pages/adminMenu.jsp" />

    <div class="container">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">

          <s:url action="deleteBookEntry" namespace="/admin/book" var="deleteTag" >
            <s:param name="bookEntryId"><s:property value="bookEntryBean.dbId"/></s:param>
          </s:url>
          <div class="d-flex flex-row-reverse">
            <div class="p-2 bd-highlight"><a class="btn btn-primary" href="<s:url action='editBookEntryFormById' namespace='/admin/book'/>">Edit Book Details</a></div>
            <div class="p-2 bd-highlight"><s:a cssClass="btn btn-danger" href="%{deleteTag}">Delete Book</s:a></div>
          </div>
          
          <hr>

          <h2>Book Details</h2>


          <div class="row">
            <div class="col-sm-12 col-md-4">
              <div class="border p-4">
                <s:if test="bookEntryBean.cover != null">
                  <img src="data:image/jpeg;base64,${bookEntryBean.cover}" class="img-fluid book-details-cover"/>
                </s:if>
              </div>
            </div>
            <div class="col-sm-12 col-md-8">
              <div class="p-4">
                <div class="row">
                  <div class="col-3">
                    dbID:
                  </div>
                  <div class="col-9">
                    <s:property value="bookEntryBean.dbId"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Title:
                  </div>
                  <div class="col-9">
                    <s:property value="bookEntryBean.title"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Authors: 
                  </div>
                  <div class="col-9">
                    <s:property value="bookEntryBean.authors"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    ISBN: 
                  </div>
                  <div class="col-9">
                    <s:property value="bookEntryBean.ISBN"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Page Count: 
                  </div>
                  <div class="col-9">
                    <s:property value="bookEntryBean.pageCount"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Publisher:  
                  </div>
                  <div class="col-9">
                    <s:property value="bookEntryBean.publisher"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Published Date: 
                  </div>
                  <div class="col-9">
                    <s:property value="bookEntryBean.publishedDate"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Genre: 
                  </div>
                  <div class="col-9">
                    <s:property value="bookEntryBean.genre"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <hr>
                  </div>
                </div>
                <div class="row">
                  <div class="col-3">
                    Available Copies: 
                  </div>
                  <div class="col-9">
                    <s:property value="availableCopies"/>
                  </div>
                </div>
                <div class="row">
                  <div class="col-12">
                    <hr>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <hr>

          <div class="d-flex flex-row-reverse">
            <div class="p-2 bd-highlight"><a class="btn btn-primary" href="<s:url action='addBookCopyRedirect' namespace='/admin/book'/>">Add Copy</a></div>
          </div>
          
          <hr>
          
          <div class="card my-4">
            <h5 class="card-header">Book Copies</h5>
            <div class="card-body">
              <div class="table-responsive">
                <table id="bookCopies" class="display" style="width:100%">
                  <thead>
                    <tr>
                      <th>Id</th>
                      <th>Serial Id</th>
                      <th>Purchase Price</th>
                      <th>Status</th>
                      <th>Action</th>
                    </tr>
                  </thead>
                  <tbody>
                    <s:iterator value="bookCopies" status="bookCopiesStatus">
                      <s:url action="editBookCopyFormById" namespace="/admin/book" var="editTag" >
                        <s:param name="id"><s:property value="dbId"/></s:param>
                      </s:url>
                      <s:url action="deleteBookCopy" namespace="/admin/book" var="deleteTag" >
                        <s:param name="bookCopyId"><s:property value="dbId"/></s:param>
                      </s:url>
                      <tr>
                        <td><s:property value="dbId"/></td>
                        <td><s:property value="serialId"/></td>
                        <td><s:property value="purchasePrice"/></td>
                        <td><s:property value="status"/></td>
                        <td>
                          <s:a cssClass="btn btn-primary" href="%{editTag}">Edit Copy Details</s:a>
                          <s:a cssClass="btn btn-danger" href="%{deleteTag}">Delete Copy</s:a>
                        </td>
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
        $('#bookCopies').DataTable({
          order: [[0, 'desc']],
        });
      });
    </script>
  </body>
</html>