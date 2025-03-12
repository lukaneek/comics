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
<title>Comic Book Store</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="./webjars/bootstrap/css/bootstrap.min.css" />
<!-- For any Bootstrap that uses JS -->
<script src="./webjars/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
	<nav class="navbar navbar-expand-lg border border-secondary"
		style="background-color: #e1ecfd">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Comic Book Store</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				</ul>
			</div>
		</div>
	</nav>
	<div class="container" style="width: 60%">
		<h3 class="fw-lighter fst-italic text-secondary-emphasis m-3">A
			place for comic lovers of all ages!</h3>
		<div class="d-flex justify-content-around">
			
			<a class="btn btn-success" href="./login">Login</a>
			<a class="btn btn-success" href="./register">Register</a>
		</div>
	</div>
</body>
</html>