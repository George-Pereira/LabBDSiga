<%@page import="dao.DaoAluno"%>
<%@page import="entity.Aluno"%>
<%@page import="dao.DaoDisciplina"%>
<%@page import="java.util.LinkedList"%>
<%@page import="entity.Disciplina"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="./style.css">
	<title>Siga - Registrar Nota</title>
</head>
<body>
	<div class="navBar">
		<ul>
		  <li><img alt="" src="./img/logosiga.png" id="logo"></li>
		  <li><a href="./index.jsp">Home</a></li>
		  <li><a href="./chamada.jsp">Chamada</a></li>
		  <li><a href="#" class="active">Registrar Nota</a></li>
		  <li class="dropdown">
		    <a class="dropbtn">Relatórios</a>
		    <div class="dropdown-content">
		      <a href="./gerarMedias.jsp">Gerar Médias</a>
		      <a href="./gerarFaltas.jsp">Gerar Faltas</a>
		    </div>
  		  </li>
		</ul>
	</div>
	
	<div align="center" style="padding:50px;">
		<form action="insereNota" method="post">
			  <label for="ra_aluno">RA do Aluno </label>
			  <select id="ra_aluno" name="ra_aluno" required>
				  <%
				  	List<Aluno> listaAlunos = new LinkedList<Aluno>();
					DaoAluno dao = new DaoAluno();
					listaAlunos = dao.getListaAlunos();
					for (Aluno aluno : listaAlunos) {
						%>
							<option value="<%=aluno.getRa() %>"><%=aluno.getNome()%></option>
						<%
					}
				  
				  
				  %>
			  </select><br><br>
			  <label for="codigo_disciplina">Código da Disciplina </label>
			  <select id="codigo_disciplina" name="codigo_disciplina" required>
				  <%
				  	List<Disciplina> listaDisciplinas = new LinkedList<Disciplina>();
					DaoDisciplina daoDisc = new DaoDisciplina();
					 listaDisciplinas = daoDisc.getListaDisciplinas();
					for (Disciplina disciplina : listaDisciplinas) {
						%>
							<option value="<%=disciplina.getCodigo() %>"><%=disciplina.toString()%></option>
						<%
					}
				  
				  
				  %>
			  </select><br><br>
			  <label for="codigo_avaliacao">Código da Avaliação </label>
			  <input type="number" id="codigo_avaliacao" name="codigo_avaliacao" min="1" max="3" required><br>
			  <label for="nota">Nota </label>
			  <input type="text" id="nota" name="nota" required><br>
			  <label for="peso">Peso </label>
			  <input type="text" id="peso" name="peso" required><br>
			  <input type="submit" value="Registrar">
			  <input type="submit" value="Editar">
			  
		</form> 
	</div>
	
</body>
</html>