<%@page import="com.projetosiga.dao.DaoAvaliacao"%>
<%@page import="com.projetosiga.entity.Avaliacao"%>
<%@page import="com.projetosiga.dao.DaoAluno"%>
<%@page import="com.projetosiga.entity.Aluno"%>
<%@page import="com.projetosiga.dao.DaoDisciplina"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.projetosiga.entity.Disciplina"%>
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
		  <li><a href="./selchamada.jsp">Chamada</a></li>
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
		<form action="./registrarNotaS.jsp" method="post">
			  <label for="codigo_disciplina">Disciplina </label>
			  <select id="codigo_disciplina" style="border-radius: 12px; border: none; color: white; background-color: gray; height: 25px;" name="codigo_disciplina" required style="height: 25px; width: 310px;">
			  	  <option>Selecione uma disciplina</option>
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
			  <input type="submit" value="Registrar Nota" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: none; border-radius: 20px">
		</form> 
	</div>
	
	<script type="text/javascript" src="script.js"></script>
</body>
</html>