<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
          <a class="navbar-brand" href="#"><i class="bi bi-bookshelf"></i></a>
          <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav me-auto mb-2 mb-lg-0">
              <li class="nav-item">
                <a class="nav-link active" aria-current="page" href="<s:url action='catalog' namespace='/'/>">Home</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" aria-current="page" href="<s:url action='dashboard' namespace='/admin'/>">Dashboard</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" aria-current="page" href="<s:url action='manageBooks' namespace='/admin'/>">Books</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" aria-current="page" href="<s:url action='manageCheckoutRequests' namespace='/admin'/>">Requests</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" aria-current="page" href="<s:url action='manageCheckoutRecords' namespace='/admin'/>">Records</a>
              </li>
            </ul>
            <s:form cssClass="d-flex" action="searchBookFromDB" namespace="/admin">
              <s:textfield name="queryTitle" cssClass="form-control me-2" type="search" placeholder="Search Book" aria-label="Search Book"/>
              <s:submit value="Admin Book Search" cssClass="btn btn-outline-success" type="submit"/>
            </s:form>
            <ul class="navbar-nav ms-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" role="button" data-bs-toggle="dropdown" aria-expanded="false">Hello, <s:property value="#session.firstName"/></a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                        <s:if test="#session.role == 'Admin'">
                          <li><a class="dropdown-item" href="<s:url action='dashboard' namespace='/admin'/>">Admin</a></li>
                        </s:if>
                        <s:else>
                          <li><a class="dropdown-item" href="<s:url action='profile' namespace='/user'/>">Profile</a></li>
                        </s:else>
                        <li><a class="dropdown-item" href="<s:url action='logout' namespace='/'/>">Logout</a></li>
                    </ul>
                </li>
            </ul>
          </div>
        </div>
      </nav>