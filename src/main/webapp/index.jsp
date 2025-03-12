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
		<div class="flex-column justify-content-center">
			<h3 class="fw-lighter fst-italic text-secondary-emphasis m-3 d-flex justify-content-center">A
			place for comic lovers of all ages!</h3>
			<div class="d-flex align-items-center justify-content-center">
			<p style="padding-right: 30px;">Already have an account? <a href="./login">Login</a></p>
			</div>
			<div class="d-flex align-items-center justify-content-center">
			<p style="padding-right: 30px;">Don't have an account? <a href="./register">Register</a></p>
			</div>
		</div>
	</div>
	<div style="padding-top: 300px; padding-left: 30px; width: 1000px">
	<h3>About this app</h3>
	
    <p>This is a spring boot application written in Java and JSP that uses a CI/CD pipeline through github, deployed on an EC2 instance in AWS.  The SQL database that this application uses is also hosted in AWS. Any changes committed to this github repository auto updates this page.</p>
    
    <p>This application will allow a normal and admin user to view/search through the library of comics and choose to either rent or buy comics. An admin user is allowed to add/update/delete comics and genres in the library.</p>
    <a target="_blank" href="https://github.com/lukaneek/comics">Link To This Applications Repository</a>
    </div>
</body>
</html>