<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- Format Date -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome <c:out value="${ user.firstName}" /></title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="./webjars/bootstrap/css/bootstrap.min.css" />
<!-- For any Bootstrap that uses JS -->
<script src="./webjars/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
	<c:set var="isAdmin" value="#{user.isAdmin == true}" />
	<c:set var="isNotAdmin"
		value="#{user.isAdmin == null or user.isAdmin == false}" />
	<nav class="navbar navbar-expand-lg border border-secondary mb-3"
		style="background-color: #e1ecfd">
		<div class="container-fluid">
			<a class="navbar-brand" href="./home">Comic Book Store</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item"><a class="nav-link active"
						aria-current="page" href="#">Home</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="./genres">Add/View Genres</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="./searchbooks">Search Library</a></li>
					<c:if test="${isAdmin}">
						<li class="nav-item"><a class="nav-link" aria-current="page"
							href="./addbook">Add a New Comic!</a></li>
					</c:if>
					<li class="nav-item"><a href="./logout" class="nav-link">Logout</a>
					</li>
				</ul>
				<div class="align-items-center justify-content-end">
					<c:if test="${isAdmin}">
						<h3 class="navbar-brand">
							Welcome, Admin
							<c:out value="${user.firstName}" />
						</h3>
					</c:if>
					<c:if test="${isNotAdmin}">
						<h3 class="navbar-brand">
							Welcome,
							<c:out value="${user.firstName}" />
						</h3>
					</c:if>
				</div>
			</div>
		</div>
	</nav>
	<div class="container bg-primary-subtle" style="width: 75%">
		<div class="container mt-3" style="width: 60%">
			<h3>Comics</h3>
			<table class="table table-hover table-bordered">
				<thead>
					<tr>
						<th>Title</th>
						<th>Issue Number</th>
						<th>Cover Image</th>
						<th>Rent / Purchase</th>
					</tr>
				</thead>
				<tbody class="table-group-divider">
					<c:forEach var="comic" items="${comics}">
						<tr>
							<td><a href="./bookdetails?id=${comic.id}"> <c:out
										value="${comic.title}" /></a></td>
							<td><c:out value="${comic.issueNumber}" />
							<td><a href="./bookdetails?id=${comic.id}"> <img
									src="./uploads/cover_pictures/${comic.coverImage}"
									alt="${comic.title}'s Cover Image" style="width: 150px;"></a></td>
							<td><c:choose>
									<c:when test="${rentedComicIds.contains(comic.id)}">
										<button class="btn btn-secondary" disabled>Currently
											Unavailable</button>
									</c:when>
									<c:otherwise>
										<form action="./books/rent/${comic.id}" method="post"
											style="display: inline;">
											<button type="submit" class="btn btn-primary">Rent
												Comic</button>
										</form>
										<form action="./books/destroy/${comic.id}" method="post"
											style="display: inline;">
											<input type="hidden" name="_method" value="delete" />
											<button type="submit" class="btn btn-success"
												onclick="return confirm('All sales are final! Continue with purchase?');">Purchase
												Comic</button>
										</form>
									</c:otherwise>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<c:if test="${not empty rentedComics}">
			<div class="container mt-3" style="width: 75%">
				<h2>My Rented Comics</h2>
				<table class="table table-hover table-bordered">
					<thead>
						<tr>
							<th>Title</th>
							<th>Issue Number</th>
							<th>Cover Image</th>
							<th>Rented Date</th>
							<th>Return / Purchase</th>
						</tr>
					</thead>
					<tbody class="table-group-divider">
						<c:forEach var="rental" items="${rentedComics}">
							<tr>
								<td><a href="./bookdetails?id=${rental.comic.id}"> <c:out
											value="${rental.comic.title}" /></a></td>
								<td><c:out value="${rental.comic.issueNumber}" />
								<td><a href="./bookdetails?id=${rental.comic.id}"> <img
										src="./uploads/cover_pictures/${rental.comic.coverImage}"
										alt="${rental.comic.title} Cover" style="width: 150px;"></a></td>
								<td><fmt:formatDate value="${rental.createdAt}"
										pattern="MM/dd/yyyy" /></td>
								<td style="display: flex;">
									<form action="./books/return/${rental.id}" method="post"
										style="margin-right: 10px;">
										<button type="submit" class="btn btn-primary mb-3">Return
											Comic</button>
									</form>
									<form action="./books/destroy/${rental.comic.id}" method="post"
										style="display: inline;">
										<input type="hidden" name="_method" value="delete" />
										<button type="submit" class="btn btn-success"
											onclick="return confirm('All sales are final! Continue with purchase?');">Purchase
											Comic</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</c:if>
	</div>
</body>
</html>