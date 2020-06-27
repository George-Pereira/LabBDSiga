<%@page import="com.projetosiga.dao.DaoAluno"%>
<%@page import="com.projetosiga.dao.IntDaoAluno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SIGA - Alunos</title>
<link rel="stylesheet" type="text/css" href="./style.css">
</head>
<body>
	<div align="center">
		<form action="./aluno" method="post">
			<label for="ra_aluno">RA</label>
			<input id="ra_aluno" type="number" name="ra" style="border-radius: 12px; border: none; color: white; background-color: gray; height: 25px;" required style="height: 25px; width: 310px;"><br>
			<label for="nome_aluno">Nome</label>
			<input type="text" id="nome_aluno" name="nome" style="border-radius: 12px; border: none; color: white; background-color: gray; height: 25px;" required style="height: 25px; width: 310px;"><br>
			<button type="submit" value="Novo_Aluno" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: none; border-radius: 20px; height: 25px; width: 100px;" >Inserir Aluno</button>
		</form>
		<%
			String msg = (String)session.getAttribute("msg");
			if(msg != null) 
			{
				session.setAttribute("msg", null);
				%>
					<div class="alert alert-success" role="alert"><%=msg%></div>
				<%
			}
		%>
	</div>
</body>
</html>