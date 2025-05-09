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
<title><c:out value="${comic.title}" /></title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="./webjars/bootstrap/css/bootstrap.min.css" />
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="./css/ComicDetails.css" />
<!-- For any Bootstrap that uses JS -->
<script src="./webjars/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
<c:set var="isAdmin" value="#{user.isAdmin == true}" />
<c:set var="isNotAdmin" value="#{user.isAdmin == null or user.isAdmin == false}"/>
	<nav class="navbar navbar-expand-lg border border-secondary mb-3" style="background-color: #e1ecfd">
		<div class="container-fluid">
			<a class="navbar-brand" href="./home">Comic Book Store</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
          				<a class="nav-link active" aria-current="page" href="./home">Home</a>
        			</li>
        			<li class="nav-item">
          				<a class="nav-link" aria-current="page" href="./genres">Add/View Genres</a>
        			</li>
        			<li class="nav-item">
          				<a class="nav-link" aria-current="page" href="./searchbooks">Search Library</a>
        			</li>
        			<c:if test="${isAdmin}">
	        			<li class="nav-item">
    	      				<a class="nav-link" aria-current="page" href="./addbook">Add a New Comic!</a>
        				</li>
        			</c:if>
        			<li class="nav-item">
          				<a href="./logout" class="nav-link">Logout</a>
        			</li>
				</ul>
			</div>
		</div>
	</nav>
		<div class="container" style="width: 30%">
			<h1><c:out value="${comic.title}" /> # <c:out value="${comic.issueNumber}"/></h1>
			<div class="d-flex justify-content-between">
				<div>
					<p><img src="./uploads/cover_pictures/${comic.coverImage}"
						alt="${comic.title}'s Cover Image" style="width: 150px;"></p>
				</div>
				<div>
					<p class="fs-5">Written By: <c:out value="${comic.author}" /></p>
					
					<p class="fs-5">Number Of Pages: <c:out value="${comic.numOfPages}" /></p>
					
					<p class="fs-5">
					Genres: 
					<c:forEach var="genre" items="${comic.genres}">
						<c:out value="${genre.name}"></c:out>			
					</c:forEach>
					</p>
				</div>		
			</div>
			<c:if test="${isAdmin}">
				<div class="d-flex justify-content-end" style="padding-right: 50px">
					<a href="./editbook?id=${comic.id}" class="btn btn-primary">Edit</a>
					<form action="./books/destroy/${comic.id}" method="post">
						<input type="hidden" name="_method" value="delete"> 
						<input style="margin-left: 15px" type="submit" value="Delete" class="btn btn-danger">
					</form>
				</div>
			</c:if>
		</div>
		<div class="container" style="width: 30%; padding-top: 50px">
			<div class="leaveCommentCard card">
					<form:form action="./comments/${comic.id}" method="POST" modelAttribute="comment">
					<p>
						<form:errors path="commentText" class="fw-lighter fst-italic text-danger" />
						<form:input type="text-area" path="commentText" class="input-group" placeholder="Leave A Comment!" required="yes" minLength="4" maxLength="600"/>
					</p>
					<div style="padding: 20px">
						<div>
							<form:label path="isRecommended">Do you Recommend This?</form:label>
							<div>
								<form:radiobutton value="True" label="Yes" path="isRecommended" required="yes"/>
								<form:radiobutton value="False" label="No" path="isRecommended" />
							</div>
						</div>
						<div class="mb-2" style="width: 20%; padding-top: 20px">
							<form:label path="commentRating">Rating (1-10)</form:label>
							<form:errors path="commentRating" class="fw-lighter fst-italic text-danger" />
							<form:input type="number" path="commentRating" class="input-group" step="1" min="1" max="10" required="yes"/>
						</div>
						<div class="buttonGroup" style="padding-top: 20px">
							<input type="submit" value="Submit" class="btn btn-primary" />
						</div>
					</div>
				</form:form>
			</div>
	
			
	
			<div style="padding-top:20px">
				<h2>Comments and Ratings</h2>
			    <c:forEach var="comment" items="${comments}">
			        <c:if test="${comic.id == comment.comic.id}">
			            <div class="commentsCard card card-body">
			                <h3 class="card-title"><c:out value="${comment.user.firstName}" /> <c:out value="${comment.user.lastName}" /></h3>
			                <p class="card-text">Review: <c:out value="${comment.commentText}" /></p>
			                <div>
			                    <c:if test="${comment.isRecommended}">
			                        <p>Recommended: Yes</p>
			                    </c:if>
			                    <c:if test="${!comment.isRecommended}">
			                        <p>Recommended: No</p>
			                    </c:if>
			                    <p>Rating: <c:out value="${comment.commentRating}" /> / 10</p>
			                </div>
			                <c:if test="${comment.user.id == userId}">
			                    <div>
			                        <form action="./comments/destroy/${comment.id}" method="post">
			                            <input type="hidden" name="_method" value="delete">
			                            <input type="submit" value="Delete" class="btn btn-danger">
			                        </form>
			                    </div>
			                </c:if>
			            </div>
			        </c:if>
			    </c:forEach>
			</div>
		</div>	
	</body>
</html>