<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Geschenkeideen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="style.css" rel="stylesheet" type="text/css" />
<%@ page import="db.GuestBookEntryTable"%>
<%@ page import="dao.Guestbookentry"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.File"%>
<%
	GuestBookEntryTable t = new GuestBookEntryTable();
	if (request.getParameter("delid") != null
			&& session.getAttribute("userid") != null) {
		t.delete(request.getParameter("delid"));
	}

	String name = request.getParameter("name");
	String nachricht = request.getParameter("nachricht");
	String check = t.checkEntry(nachricht);
	if (name != null && name.length() > 0 && nachricht != null
			&& nachricht.length() > 0) {
		if (check != null && check.length() == 0) {
			t.save(new Guestbookentry(-1, name, nachricht));
		} else if (check != null && check.length() > 0) {
%>
<script type="text/javascript">alert("Sie haben Schimpfwörter benutzt, deshalb wird ihr Eintrag nicht gespeichert: <%=check.replace("\n", "")%>");
</script>

<%
	}
	}
%>
<script type="text/javascript">
	function reset() {
		document.getElementsByName("nachricht")[0].value = '';
		document.getElementsByName("name")[0].value = '';
	}
	function del(id) {
		hid = document.getElementById("delid");
		hid.value = id;
		document.forms[0].submit();

	}
</script>
</head>
<body>
	<div id="toptop">Geschenketraum</div>
	<div id="top"></div>
	<div id="columns">
		<div id="left">
			<h1 style="text-align: center">Die besten Geschenke des Jahres</h1>
			<div>Wenn ihr gute Geschenke zu jeder Jahreszeit sucht, dann seid ihr hier genau
			richtig. Wird haben die schönsten Geschenkideen, ob klein oder groß, ob jung oder alt, für jeden ist was dabei.</div>
			<div align="center" style="float:left; clear:left;">
				<form method="post" action="geschenke.jsp">
					<%
						if (session.getAttribute("userid") != null) {
					%>
					<input type="hidden" id="delid" name="delid" value="" />
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
					<%
						}
					%>
					<div align="center">

						<%
							ArrayList<Guestbookentry> entries = t.getAll();
						%>
						<%
							for (Guestbookentry entry : entries) {
						%>
						<div class="Entry_name">
							<%=entry.getName()%>
							<%
								if (session.getAttribute("userid") != null) {
							%>
							<a href='javascript:del(<%=entry.getId()%>);'
								style='color: red; background-color: #fbf4a0; float: right;'>X</a>
							<%
								}
							%>
						</div>
						<div><img src="sh test.sh"/></div>
						<div class="Entry_name">
							<%=entry.getEntry()%>
						</div>
						<br />
						<%
							}
						%>
					</div>
				</form>
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