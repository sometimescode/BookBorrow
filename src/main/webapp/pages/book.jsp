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

    <link rel="stylesheet" href="css/general.css">

    <title>Book Information</title>

    <style>
      .book-details-cover {
        width: 100%;
      }
    </style>
  </head>
  <body>
    <s:include value="menu.jsp" />

    <div class="container">
      <div class="card border-0 shadow my-5">
        <div class="card-body p-5">

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
                <div class="row">
                  <div class="col-12">
                    <s:if test="availableCopies > 0">
                      <s:if test="submittedPendingRequest == true">
                        <div class="card-footer text-muted">
                          Checkout Request already submitted. Check <a href="<s:url action='profile' namespace='/user'/>">Profile</a> for status.
                        </div>
                      </s:if>
                      <s:else>
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                          Request Checkout
                        </button>
                      </s:else>
                    </s:if>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <hr>
          
        </div>
      </div>
    </div>

    <!-- Modal -->
    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="staticBackdropLabel">Confirm Checkout Request</h5>
            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
          </div>
          <!-- <div class="modal-body">
          </div> -->
          <div class="modal-footer">
            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
            <s:form action="requestCheckout">
              <s:submit value="Confirm" cssClass="btn btn-primary"/>
            </s:form>
          </div>
        </div>
      </div>
    </div>
    
    <!-- Bootstrap Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>