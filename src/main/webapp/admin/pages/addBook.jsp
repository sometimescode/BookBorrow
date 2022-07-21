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

    <link rel="stylesheet" href="../css/general.css">

    <title>Admin - Add Book</title>

    <sj:head/>

    <style>
      .book-cover {
        width:148px;
        height:200px;
      }
    </style>
  </head>
  <body class="admin">
    <s:include value="adminMenu.jsp" />

    <div class="container">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">

          <h1>Add Book</h1>

          Auto-populate form with details from OpenLibrary using ISBN with the search form below or manually input the details.
          <s:form action="searchBookFromOpenLibrary">
            <s:textfield name="queryISBN" label="ISBN"/> 
            <s:submit value="Search"/>
          </s:form>

          <div class="d-flex justify-content-center">
            <s:if test="openLibraryBookEntryBean.cover != null">
              <img src="${openLibraryBookEntryBean.cover}" class="book-cover" alt="${openLibraryBookEntryBean.title}">
            </s:if>
            <s:else>
              <s:if test="bookEntryBean.cover != null">
                <img src="${bookEntryBean.cover}" class="book-cover" alt="${bookEntryBean.title}">
              </s:if>
            </s:else>
          </div>

          <div class="row">
            <div class="col-sm-12 col-md-4 p-4">
              <div class="card">
                <div class="card-header">
                  OPENLIBRARY ISBN Result
                </div>
                <div class="card-body p-1">
                  <h5 class="card-title"></h5>
                  <p class="card-text">For reference. Fields might not always have values.</p>
                  <s:form action="copyToAddBookForm">
                    <div class="input-group mb-3">
                      <span class="input-group-text">Title</span>
                      <s:textfield cssClass="form-control" name="openLibraryBookEntryBean.title" label="Title"/>
                    </div>
                    <div class="input-group mb-3">
                      <span class="input-group-text">Author(s)</span>
                      <s:textfield cssClass="form-control" name="openLibraryBookEntryBean.authors" label="Author(s)"/>
                    </div>
                    <div class="input-group mb-3">
                      <span class="input-group-text">ISBN</span>
                      <s:textfield cssClass="form-control" name="openLibraryBookEntryBean.ISBN" label="ISBN"/>
                    </div>
                    <div class="input-group mb-3">
                      <span class="input-group-text">Page Count</span>
                      <s:textfield cssClass="form-control" name="openLibraryBookEntryBean.pageCount" label="Page Count"/>
                    </div>
                    <div class="input-group mb-3">
                      <span class="input-group-text">Publisher</span>
                      <s:textfield cssClass="form-control" name="openLibraryBookEntryBean.publisher" label="Publisher"/>
                    </div>
                    <div class="input-group mb-3">
                      <span class="input-group-text">Published Date</span>
                      <s:textfield cssClass="form-control" name="openLibraryBookEntryBean.publishedDate" label="Published Date"/>
                    </div>
                    <s:hidden name="openLibraryBookEntryBean.cover"/>
                    <s:submit cssClass="btn btn-secondary w-100" value="Copy to Form"/>
                  </s:form>
                </div>
              </div>
            </div>
            <div class="col-sm-12 col-md-8">
              <div class="p-4">
                <s:form action="addBookEntry">
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
                    <s:textfield cssClass="form-control" id="floatingISBN" name="bookEntryBean.ISBN" placeholder="ISBN"/>
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
                  <s:hidden name="bookEntryBean.cover"/>
                  <s:if test="!validationString.isEmpty()">
                    <p class="text-danger"><i class="bi bi-info-square-fill"></i> <s:property escapeHtml="false" value="validationString"/><p>
                  </s:if> 
                  <s:submit cssClass="btn btn-primary w-100" value="Submit"/>
                </s:form>
              </div>
            </div>
          </div>
      
        </div>
      </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>