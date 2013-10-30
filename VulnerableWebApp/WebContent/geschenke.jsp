<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Geschenkeideen</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link href="geschenkeStyle.css" rel="stylesheet" type="text/css" />
<%@ page import="db.GiftTable"%>
<%@ page import="dao.Gift"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*"%>
<%@ page import="javax.servlet.http.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>
<%@ page import="org.apache.commons.fileupload.FileItem"%>
<%@ page import="org.apache.commons.fileupload.disk.*"%>
<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.io.*"%>


<%
	File file;
	ServletContext context = pageContext.getServletContext();
	String filePath = context.getInitParameter("file-upload");
	//String filePath = context.getInitParameter("file-upload");
	String name = null;
	String beschreibung = null;
	String zeit = null;
	String material = null;
	String anleitung = null;
	String bild = null;
	String delid = null;
	InputStream filecontent = null;
	// Verify the content type
	String contentType = request.getContentType();
	if (contentType != null
			&& (contentType.indexOf("multipart/form-data") >= 0)) {

		try {
			List<FileItem> items = new ServletFileUpload(
					new DiskFileItemFactory()).parseRequest(request);
			for (FileItem item : items) {
				if (item.isFormField()) {
					// Process regular form field (input type="text|radio|checkbox|etc", select, etc).
					String fieldname = item.getFieldName();
					String fieldvalue = item.getString();
					if (fieldname.equals("name")) {
						name = fieldvalue;
					} else if (fieldname.equals("beschreibung"))
						beschreibung = fieldvalue;
					else if (fieldname.equals("zeit"))
						zeit = fieldvalue;
					else if (fieldname.equals("material"))
						material = fieldvalue;
					else if (fieldname.equals("anleitung"))
						anleitung = fieldvalue;
					else if (fieldname.equals("delid"))
						delid = fieldvalue;
				} else {
					// Process form file field (input type="file").
					String fieldname = item.getFieldName();
					String filename = FilenameUtils.getName(item
							.getName());
					filecontent = item.getInputStream();
					if (fieldname.equals("datei"))
						bild = "img/giftpics/" + filename;
				}
			}
		} catch (FileUploadException e) {
			throw new ServletException(
					"Cannot parse multipart request.", e);
		}
	}
%>
<%
	GiftTable t = new GiftTable();
	if (delid != null && session.getAttribute("userid") != null) {
		t.delete(delid);
	}

	if (name != null && name.length() > 0 && beschreibung != null
			&& beschreibung.length() > 0 && zeit != null
			&& zeit.length() > 0 && material != null
			&& material.length() > 0 && anleitung != null
			&& anleitung.length() > 0 && bild != null
			&& bild.length() > 0) {
		file = new File(filePath + "/" + bild);
		FileOutputStream fw = new FileOutputStream(file);
		String path = getServletContext().getRealPath("/");
		FileOutputStream serverfw = new FileOutputStream(new File(path
				+ bild));
		int ch = filecontent.read();
		while (ch != -1) {
			serverfw.write(ch);
			fw.write(ch);
			ch = filecontent.read();
		}
		filecontent.close();
		serverfw.close();
		fw.close();
		t.save(new Gift(-1, name, beschreibung, zeit, material,
				anleitung, bild));

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
			<div>Wenn ihr gute Geschenke zu jeder Jahreszeit sucht, dann
				seid ihr hier genau richtig. Wird haben die schönsten Geschenkideen,
				ob klein oder groß, ob jung oder alt, für jeden ist was dabei.</div>
			<div align="center" style="float: left; clear: left;">
				<form method="post" action="geschenke.jsp"
					enctype="multipart/form-data">
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
							<td>Bild:</td>
							<td><input name="datei" type="file" /></td>
						</tr>
						<tr>
							<td>Beschreibung:</td>
							<td><textarea name="beschreibung" rows="8" cols="34"
									style="border-width: 1" class="textarea_nachricht"></textarea>
							</td>
						</tr>
						<tr>
							<td>Benötigte Zeit:</td>
							<td><input type="Text" size="40" maxlength="40" name="zeit"
								value="" style="border-width: 1" class="inputfeld_name" /></td>
						</tr>
						<tr>
							<td>Materialien:</td>
							<td><textarea name="material" rows="8" cols="34"
									style="border-width: 1" class="textarea_nachricht"></textarea>
							</td>
						</tr>
						<tr>
							<td>Anleitung:</td>
							<td><textarea name="anleitung" rows="8" cols="34"
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
				</form>
				<div align="center">

					<%
						ArrayList<Gift> entries = t.getAll();
					%>
					<%
						for (Gift entry : entries) {
					%>

					<div class="Entry_name">
						<h2><%=entry.getName()%></h2>
						<img src='<%=entry.getPicturePath()%>' width="268" height="283" />

						<%
							if (session.getAttribute("userid") != null) {
						%>
						<a href='javascript:del(<%=entry.getId()%>);'
							style='color: red; background-color: #fbf4a0; float: right;'>X</a>
						<%
							}
						%>
					</div>
					<div class="Entry_desc">
						<p>
							<%=entry.getDescription()%>
						</p>
						Benötigte Zeit:
						<%=entry.getTime()%>
						<br /> Materialien:<br />
						<ul>
							<%
								String[] mats = entry.getMaterials().split(",");
									for (String mat : mats) {
							%>

							<li><%=mat%></li>
							<%
								}
							%>

						</ul>
						Anleitung: <br />
						<%=entry.getInstructions()%>
					</div>
					<br />
					<%
						}
					%>
				</div>

			</div>
		</div>
		<div id="right">
			<h1>Navigation</h1>
			<ul>
				<li><a href="home.jsp">home</a></li>
				<li><a href="guestbook.jsp">Gästebuch</a></li>
				<%
					if (session.getAttribute("userid") == null) {
				%>
				<li><a href="login.jsp">Login</a></li>
				<%
					} else {
				%>
				<li><a href="login.jsp?logout=ausloggen">Logout</a></li>
				<%
					}
				%>
				<li><a href="geschenke.jsp">Geschenkideen</a></li>
			</ul>
		</div>
	</div>
	<div id="footer">
		<p>&copy; 2006 Genschenketraum GbR</p>
	</div>
</body>
</html>
