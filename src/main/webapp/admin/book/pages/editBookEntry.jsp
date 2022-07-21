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
    
    <link rel="stylesheet" href="../../css/general.css">

    <title>Admin - Book Information</title>
    
    <sj:head/>

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

          <div class="d-flex flex-row-reverse">
            <s:url action="getBookEntryByISBN" namespace="/admin/book" var="urlTag" >
              <s:param name="ISBN"><s:property value="bookEntryBean.ISBN"/></s:param>
            </s:url>
            <div class="p-2 bd-highlight">
              <s:a cssClass="float-end btn btn-primary" href="%{urlTag}">Back</s:a>
            </div>
          </div>
          
          <hr>

          <h1>Edit Book Details</h1>
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
                  <s:form action="editBookEntry">
                    <s:textfield name="bookEntryBean.cover" hidden="true"/>
                    <s:textfield name="bookEntryBean.ISBN" hidden="true"/>
                    <div class="form-floating mb-3">
                      <s:textfield cssClass="form-control" id="floatingTitle" name="bookEntryBean.title" placeholder="Title"/>
                      <label for="floatingTitle">Title</label>
                      <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="bookEntryBean.title" />
                    </div>
                    <div class="form-floating mb-3">
                      <s:textfield cssClass="form-control" id="floatingAuthors" name="bookEntryBean.authors" placeholder="Author(s)"/>
                      <label for="floatingAuthors">Author(s)</label>
                      <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="bookEntryBean.authors" />
                    </div>
                    <div class="form-floating mb-3">
                      <s:textfield cssClass="form-control" id="floatingISBN" name="bookEntryBean.ISBN" placeholder="ISBN" disabled="true"/>
                      <label for="floatingISBN">ISBN</label>
                      <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="bookEntryBean.ISBN" />
                    </div>
                    <div class="form-floating mb-3">
                      <s:textfield cssClass="form-control" id="floatingPageCount" name="bookEntryBean.pageCount" placeholder="Page Count"/>
                      <label for="floatingPageCount">Page Count</label>
                      <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="bookEntryBean.pageCount" />
                    </div>
                    <div class="form-floating mb-3">
                      <s:textfield cssClass="form-control" id="floatingPublisher" name="bookEntryBean.publisher" placeholder="Publisher"/>
                      <label for="floatingPublisher">Publisher</label>
                      <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="bookEntryBean.publisher" />
                    </div>
                    <div class="form-floating mb-3">
                      <sj:datepicker cssClass="form-control" placeholder="Published Date" id="floatingPublishedDate" name="bookEntryBean.publishedDate" changeMonth="true" changeYear="true" showOn="focus"/>
                      <label for="floatingPublishedDate">Published Date</label>
                      <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="bookEntryBean.publishedDate" />
                    </div>
                    <div class="form-floating mb-3">
                      <s:select cssClass="form-control form-select" id="floatingGenre" name="bookEntryBean.genre" placeholder="Genre" emptyOption="true" list="genreList"/>
                      <label for="floatingGenre">Genre</label>
                      <s:fielderror cssClass="text-danger col-form-label-sm" fieldName="bookEntryBean.genre" />
                    </div>
                    <s:submit cssClass="btn btn-primary w-100" value="Edit"/>
                  </s:form>
              </div>
            </div>
          </div>

          <hr>

        </div>
      </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>