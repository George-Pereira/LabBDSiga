<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.projetosiga.dao.IntDaoDisciplina" %>
<%@ page import="com.projetosiga.entity.Disciplina"%>
<%@ page import="com.projetosiga.dao.DaoDisciplina"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="./style.css">
	<title>Siga - Gerar Faltas</title>
</head>
<body>
	<header>
		<div class="navBar">
			<ul>
			  <li><img alt="" src="./img/logosiga.png" id="logo"></li>
			  <li><a href="./index.jsp">Home</a></li>
			  <li><a href="./selchamada.jsp">Chamada</a></li>
			  <li><a href="./registrarNota.jsp">Registrar Nota</a></li>
			  <li class="dropdown">
			    <a class="dropbtn active">Relatórios</a>
			    <div class="dropdown-content">
			      <a href="./gerarMedias.jsp">Gerar Médias</a>
			      <a class="active" href="./gerarFaltas.jsp">Gerar Faltas</a>
			    </div>
	  		  </li>
			</ul>
		</div>
	</header>
</body>
	<form action="relatoriofaltas" method="post">
		<div align="center" style="padding:50px">
			<label for="disciplina">Disciplina</label>
			<select id="disciplina" style="border-radius: 12px; border: none; color: white; background-color: gray; height: 25px;"name="disciplina" required style="height: 25px; width: 310px;"onchange="listaAlunosporDisciplina(document.getElementById('codigo_disciplina').value)">
				<% 
					List<Disciplina> listDisc = new LinkedList<Disciplina>();
					IntDaoDisciplina dao = new DaoDisciplina();
					listDisc = dao.getListaDisciplinas();
					for(Disciplina disc : listDisc)
					{
				%>
					<option value="<%=disc.getCodigo() %>"><%=disc.toString() %></option>
				<%
					}
				%>
			</select><br>
			<input type="submit" value="Consultar Relatório de Faltas" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: none; border-radius: 20px">
		</div>
	</form>
</html>