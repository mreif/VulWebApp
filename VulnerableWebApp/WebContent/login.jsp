<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="style.css" rel="stylesheet" type="text/css" />
</head>
<body>
	<div id="toptop">Geschenketraum</div>
	<div id="top"></div>
	<div id="columns">
		<div id="left">
			<h1 style="text-align: center">Willkommen</h1>
			<%
				if (request.getParameter("logout") != null
						&& request.getParameter("logout").equals("ausloggen")) {
			%>
			<div style="text-align: center">Seit ihr ein Administrator oder
				Moderator dieser Seite, dann logt euch hier ein.</div>
			<%
				}
			%>
			<div align="center">

				<form method="get" action="login.jsp">
					<%
						if (session.getAttribute("userid") == null) {
					%>
					<table style="text-align: left; border-spacing: 10px 20px;">
						<tr>
							<td>Benutzername:</td>
							<td><input type="Text" size="40" maxlength="40" name="name"
								value="" style="border-width: 1" class="inputfeld_name" /></td>
						</tr>
						<tr>
							<td>Passwort:</td>
							<td><input name="passwd" type="password"
								style="border-width: 1" class="inputfeld_name"></input></td>
						</tr>
						<tr>
							<td></td>
							<td><input type="submit" value="login" class="submit" /></td>
						</tr>
					</table>
					<%
						} else if (request.getParameter("logout") != null
								&& request.getParameter("logout").equals("ausloggen")) {
							session.removeAttribute("userid");
							response.sendRedirect("login.jsp");
						} else {
					%>
					<span style="color: green">Sie sind bereits eingeloggt!</span> <input
						type="submit" name="logout" value="ausloggen" class="submit" />
					<%
						}
					%>
				</form>

				<%@ page import="db.UserTable"%>
				<%@ page import="dao.User"%>
				<%
					UserTable t = new UserTable();
				%>
				<%
					String name = request.getParameter("name");
					String passwd = request.getParameter("passwd");
					if (name != null && passwd != null) {
						int check = t.validateUser(name, passwd);
						if (check == 1) {
				%>
				<span style="color: red">Der Benutzername ist falsch. Bitte
					geben Sie einen gültigen Benutzernamen ein.</span>
				<%
					} else if (check == 2) {
				%>
				<span style="color: red">Das Passwort ist falsch. Bitte geben
					Sie ein gültiges Passwort ein.</span>
				<%
					} else {
							session.setAttribute("userid", name);
							response.sendRedirect("login.jsp");
						}
					}
				%>
			</div>
		</div>
		<div id="right">
			<h1>Navigation</h1>
			<ul>
				<li><a href="http://www.free-css.com/">home</a></li>
				<li><a href="guestbook.jsp">Gästebuch</a></li>
				<li><a href="login.jsp">Login</a></li>
				<li><a href="geschenke.jsp">Geschenkideen</a></li>
			</ul>
		</div>
	</div>
	<div id="footer">
		<p>&copy; 2006 Genschenketraum GbR</p>
	</div>
</body>
</html>
