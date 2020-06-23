<%@page import="java.util.LinkedList"%>
<%@page import="com.projetosiga.dao.DaoDisciplina"%>
<%@page import="com.projetosiga.entity.Disciplina"%>
<%@page import="com.projetosiga.dao.DaoAluno"%>
<%@page import="com.projetosiga.entity.Aluno"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Matricula</title>
<link rel="stylesheet" type="text/css" href="./style.css">
</head>
<body>
	<%
		List<Aluno> alunos = new LinkedList<Aluno>();
		DaoAluno daoAluno = new DaoAluno();
		alunos = daoAluno.getTodosAlunos();
		
		List<Disciplina> disciplinas = new LinkedList<Disciplina>();
		DaoDisciplina daoDisciplina =  new DaoDisciplina();
		disciplinas = daoDisciplina.getListaDisciplinas();
	%>
	
	<div align="center" style="margin-top: 50px">
		<form action="./matricula" method="post">
			  <label for="codigo_disciplina">Disciplina </label>
			  <select id="codigo_disciplina" style="border-radius: 12px; border: none; color: white; background-color: gray; height: 25px;" name="codigo_disciplina" required style="height: 25px; width: 310px;">
			  	  <option>Selecione uma disciplina</option>
				  <%
					for (Disciplina disciplina : disciplinas) {
						%>
							<option value="<%=disciplina.getCodigo() %>"><%=disciplina.toString()%></option>
						<%
					}
				  %>
			  </select><br><br>
			  <label for="codigo_aluno">Aluno </label>
			  <select id="codigo_aluno" style="border-radius: 12px; border: none; color: white; background-color: gray; height: 25px;" name="codigo_aluno" required style="height: 25px; width: 310px;">
			  	  <option>Selecione um aluno</option>
				  <%
					for (Aluno aluno : alunos) {
						%>
							<option value="<%=aluno.getRa() %>"><%=aluno.getNome()%></option>
						<%
					}
				  %>
			  </select><br><br>
			  <input type="submit" value="Matricular Aluno" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: none; border-radius: 20px">
		</form> 
		<%
			String msg = (String)session.getAttribute("msg");
			if(msg != null) {
				session.setAttribute("msg", null);
				%>
					<div class="alert alert-success" role="alert"><%= msg%></div>
				<%
			}
		%>
	</div>
</body>
</html>