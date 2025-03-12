<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit ${comic.title}</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="./webjars/bootstrap/css/bootstrap.min.css" />
<!-- For any Bootstrap that uses JS -->
<script src="./webjars/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
<c:set var="isAdmin" value="#{user.isAdmin == true}" />
<c:set var="isNotAdmin" value="#{user.isAdmin == null or user.isAdmin == false}"/>
	<nav class="navbar navbar-expand-lg border border-secondary mb-3" style="background-color: #e1ecfd">
		<div class="container-fluid">
			<a class="navbar-brand" href="/home">Comic Book Store</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
          				<a class="nav-link active" aria-current="page" href="#">Home</a>
        			</li>
        			<li class="nav-item">
          				<a class="nav-link" aria-current="page" href="/genres">Add/View Genres</a>
        			</li>
        			<li class="nav-item">
          				<a class="nav-link" aria-current="page" href="/searchbooks">Search Library</a>
        			</li>
        			<c:if test="${isAdmin}">
	        			<li class="nav-item">
    	      				<a class="nav-link" aria-current="page" href="/addBooks">Add a New Comic!</a>
        				</li>
        			</c:if>
        			<li class="nav-item">
          				<a href="/logout" class="nav-link">Logout</a>
        			</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container" style="width: 50%">
		<h1>Edit Comic</h1>
		<form:form action="/books/${comic.id}" method="post" modelAttribute="comic" enctype="multipart/form-data">
		<input type="hidden" name="_method" value="put">
			<div class="mb-2">
				<form:label class="form-label" path="title">Title</form:label>
				<form:input class="form-control" path="title"/>
				<form:errors class="fw-lighter fst-italic text-danger" path="title"/>
			</div>
			<div class="mb-2">
				<form:label class="form-label" path="author">Author</form:label>
				<form:input class="form-control" path="author"/>
				<form:errors class="fw-lighter fst-italic text-danger" path="author"/>
			</div>
			<div class="mb-2">
				<form:label class="form-label" path="publisher">Publisher</form:label>
				<form:input class="form-control" path="publisher"/>
				<form:errors class="fw-lighter fst-italic text-danger" path="publisher"/>
			</div>
			<div class="mb-2">
				<form:label class="form-label" path="numOfPages">Number Of Pages</form:label>
				<form:input class="form-control" min="1" max="500" type="number" path="numOfPages"/>
				<form:errors class="fw-lighter fst-italic text-danger" path="numOfPages"/>
			</div>
			<div class="mb-3">
				<h6>Select the genre(s)</h6>
				<c:forEach var="genre" items="${genres}">
					<form:label class="form-check-label" path="genres"><c:out value="${genre.name}"></c:out></form:label>
					<form:checkbox class="form-check-input me-3" path="genres" value="${genre}"/>
				</c:forEach>
			</div>
            <div class="mb-2">
                <form:label class="form-label" path="coverImage">Comic Book Cover</form:label>
                <input type="file" id="coverPicture" name="coverPicture"/>
                <form:errors class="fw-lighter fst-italic text-danger" path="coverImage"/>
            </div>

			 <input type="submit" value="Submit" class="btn btn-success" />
			
		</form:form>
	</div>
</body>
</html>