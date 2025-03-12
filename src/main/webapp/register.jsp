<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- For JSTL Forms -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login And Register</title>
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="./webjars/bootstrap/css/bootstrap.min.css" />
<!-- For any Bootstrap that uses JS -->
<script src="./webjars/bootstrap/js/bootstrap.min.js"></script>

</head>
<body>
	<nav class="navbar navbar-expand-lg border border-secondary" style="background-color: #e1ecfd">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Comic Book Store</a>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">
				<ul class="navbar-nav me-auto mb-2 mb-lg-0">
					<li class="nav-item">
          				<a class="nav-link active" aria-current="page" href="./login">Login</a>
        			</li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container" style="width: 60%">
		<div class="d-flex justify-content-around">
			<div>
				<div>
					<form:form action="./register" method="post" modelAttribute="newUser">
						<h2>Register</h2>
						<p class="fw-lighter fst-italic text-secondary-emphasis">Please enter your email and create a password!</p>
						<div class="mb-2">
							<form:label class="form-label" path="firstName">First Name</form:label>
							<form:input class="form-control" type="text" path="firstName" placeholder="First Name" />
							<form:errors class="fw-lighter fst-italic text-danger" path="firstName"/>
						</div>
						<div class="mb-2">
							<form:label class="form-label" path="lastName">Last Name</form:label>
							<form:input class="form-control" type="text" path="lastName" placeholder="Last Name" />
							<form:errors class="fw-lighter fst-italic text-danger" path="lastName" />
						</div>
						<div class="mb-2">
							<form:label class="form-label" path="email">Email</form:label>
							<form:input class="form-control" type="email" path="email" placeholder="Email" />
							<form:errors class="fw-lighter fst-italic text-danger" path="email" />
						</div>
						<div class="mb-2">
							<form:label class="form-label" path="password">Password</form:label>
							<form:input class="form-control" type="password" path="password" placeholder="Password" />
							<form:errors class="fw-lighter fst-italic text-danger" path="password" />
						</div>
						<div class="mb-2">
							<form:label class="form-label" path="confirm">Confirm Password</form:label>
							<form:input class="form-control" type="password" path="confirm" placeholder="Confirm Password" />
							<form:errors class="fw-lighter fst-italic text-danger" path="confirm" />
						</div>
						<div class="mb-2">
							<form:label class="form-check-label" path="isAdmin">Admin Access</form:label>
							<form:checkbox class="form-check-input me-3" path="isAdmin"/>
						</div>
						<input class="btn btn-primary" type="submit" name="" value="Register">
					</form:form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>