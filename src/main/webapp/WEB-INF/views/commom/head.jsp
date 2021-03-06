<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf8" />
		<meta name="viewport" content="width=device-width, initial-scale=1">

		<title>
			<fmt:message key="app.name" />
		</title>
	
		<link href="<c:url value="/public/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value="/public/css/font-awesome.min.css"/>" rel="stylesheet" type="text/css" />
		<link href="<c:url value="/public/css/parking.css"/>" rel="stylesheet" type="text/css" />
		
		<script type="text/javascript" src="<c:url value="/public/js/jquery-3.2.1.min.js"/>"></script>
	</head>
	
	<body>
		<nav class="navbar navbar-inverse navbar-static-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle collapsed"
						data-toggle="collapse" data-target="#navbar" aria-expanded="false"
						aria-controls="navbar">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">Project name</a>
				</div>
				<div id="navbar" class="navbar-collapse collapse">
					<ul class="nav navbar-nav navbar-right">
						<li id="menu-vehicles">
							<a href="<c:url value="/parkings" />"> 
								<i class="fa fa-car"></i> 
								<fmt:message key="parked.vehicles" />
							</a>
						</li>
						
						<li id="menu-settings">
							<a href="<c:url value="/settings" />"> 
								<i class="fa fa-cog"></i>
								<fmt:message key="settings" />
							</a>
						</li>
						<!--<li>
							<p class="navbar-text">
								User Name
								<a href="#" class="navbar-link">
									<i class="fa fa-sign-out"></i>
								</a>
							</p>
						</li> -->
					</ul>
				</div>
				<!--/.nav-collapse -->
			</div>
		</nav>
	
		<div class="container">
			<c:if test="${ alert != null }">			
				<div class="alert alert-${alert.type} alert-dismissable">
			    	<a href="#" class="close" data-dismiss="alert" aria-label="close">×</a>
			    	${alert.message}
			  	</div>
			</c:if>
		
			<ol class="breadcrumb">
				<c:forEach var="breadcrumb" items="${breadcrumbList}">
					<c:choose>
						<c:when test="${breadcrumb.active}">
							<li> 
								<fmt:message key="${breadcrumb.messageKey}" />  
							</li>
						</c:when>
						
						<c:otherwise>
							<li class="active">
								<a href="${breadcrumb.link}"> 
									<fmt:message key="${breadcrumb.messageKey}" /> 
								</a>
							</li>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</ol>
		</div>