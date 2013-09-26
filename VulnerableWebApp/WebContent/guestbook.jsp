<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="db.GuestBookEntryTable"%>
<%@ page import="dao.Guestbookentry"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.File"%>
<%
	GuestBookEntryTable t = new GuestBookEntryTable();
%>
<%
	String name = request.getParameter("name");
	String nachricht = request.getParameter("nachricht");
	String check = t.checkEntry(nachricht);
	if (name != null && name.length() > 0 && nachricht != null
			&& nachricht.length() > 0) {
		if (check != null && check.length() == 0) {
			t.save(new Guestbookentry(-1, name, nachricht));
		} else if (check != null) {%>
		<script type="text/javascript">alert("<%=check.replace("\n","")%>")</script>

<%}
	}%>



<html>
<head>
<title>Gästebuch</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function reset() {
		document.getElementsByName("nachricht")[0].value = '';
		document.getElementsByName("name")[0].value = '';
	}
</script>
</head>
<body>
	<div id="toptop">Geschenketraum</div>
	<div id="top"></div>
	<div id="columns">
		<div id="left">
			<h1 style="text-align: center">Willkommen zu unserem Gästebuch</h1>
			<div style="clear: left; float: left">Dieses Gästebuch ist für
				Freunde der Geschenketraum GbR und Personen die gute Geschenkideen
				schätzen. Wenn ihr eine gute Geschenkidee habt, die ihr auf dieser
				Seite vermisst, schreibt die Idee einfach hier rein.</div>
			<div align="center">
				<form method="post" action="guestbook.jsp">
					<table style="text-align: left; border-spacing: 10px 20px;">
						<tr>
							<td>Name:</td>
							<td><input type="Text" size="40" maxlength="40" name="name"
								value="" style="border-width: 1" class="inputfeld_name" /></td>
						</tr>
						<tr>
							<td>Nachricht:</td>
							<td><textarea name="nachricht" rows="8" cols="34"
									style="border-width: 1" class="textarea_nachricht"></textarea>
							</td>
						</tr>
						<tr>
							<td></td>
							<td><input type="submit" value="save" class="submit" /> <input
								type="button" value="reset" class="submit"
								onclick="javascript:reset();" /></td>
						</tr>
					</table>
				</form>
			</div>
			<div align="center">

				<%
					ArrayList<Guestbookentry> entries = t.getAll();
				%>
				<%
					for (Guestbookentry entry : entries) {
				%>
				<div class="Entry_name">
					<%=entry.getName()%>
				</div>
				<div class="Entry_name">
					<%=entry.getEntry()%>
				</div>
				<br />
				<%
					}
				%>
			</div>
		</div>
		<div id="right">
			<h1>Navigation</h1>
			<ul>
				<li><a href="http://www.free-css.com/">home</a></li>
				<li><a href="guestbook.jsp">Gästebuch</a></li>
				<li><a href="http://www.free-css.com/">Link 2</a></li>
				<li><a href="http://www.free-css.com/">Link 3</a></li>
			</ul>
		</div>
	</div>
	<div id="footer">
		<p>&copy; 2006 Genschenketraum GbR</p>
	</div>
</body>
</html>
