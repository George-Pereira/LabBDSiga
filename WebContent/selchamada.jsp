<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.projetosiga.dao.IntDaoAluno"%>
<%@page import="com.projetosiga.entity.Disciplina"%>
<%@page import="com.projetosiga.entity.Aluno"%>
<%@page import="com.projetosiga.dao.DaoDisciplina"%>
<%@page import="com.projetosiga.dao.DaoAluno"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="com.projetosiga.dao.IntDaoDisciplina" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="./style.css">
	<title>Siga - Chamada</title>
</head>
<body>
	<div class="navBar">
		<ul>
		  <li><img alt="" src="./img/logosiga.png" id="logo"></li>
		  <li><a href="./index.jsp">Home</a></li>
		  <li><a href="#" class="active">Chamada</a></li>
		  <li><a href="./registrarNota.jsp">Registrar Nota</a></li>
		  <li class="dropdown">
		    <a class="dropbtn">Relatórios</a>
		    <div class="dropdown-content">
		      <a href="./gerarMedias.jsp">Gerar Médias</a>
		      <a href="./gerarFaltas.jsp">Gerar Faltas</a>
		    </div>
  		  </li>
		</ul>
	</div>
	<form action="./chamada.jsp" method="post">
		<div align="center" style="padding:50px;">
			<label for="disciplina">Disciplina</label>
			<select id="disciplina" style="border-radius: 12px; border: none; color: white; background-color: gray; height: 25px;"name="disciplina" required style="height: 50px; width: 310px;"onchange="listaAlunosporDisciplina(document.getElementById('codigo_disciplina').value)">
				<% 
					List <Disciplina> listDisc = new LinkedList<Disciplina>();
					IntDaoDisciplina dao = new DaoDisciplina();
					listDisc = dao.getListaDisciplinas();
					for(Disciplina disc : listDisc)
					{
				%>
					<option value="<%=disc.getCodigo() %>" style="border: none; background-color: gray; color: white;"><%=disc.toString() %></option>
				<%
					}
				%>
			</select><br>
			<%
			Date hoje = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(hoje);
			int ano = cal.get(Calendar.YEAR);
			String mes = String.valueOf(cal.get(Calendar.MONTH) + 1);
			if (mes.length() < 2 ) {
				mes = "0"+mes;
			}
			int dia = cal.get(Calendar.DAY_OF_MONTH);
			%>
			<label for="data">Data</label>
			<input id="data" name="data" style="border-radius: 12px; border: none; height: 20px; color: white; background-color: gray;" type="date" value="<%=ano %>-<%=mes %>-<%=dia%>">
		    <input type="submit" value="Gerar Chamada" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: none; border-radius: 20px">
		</div>
	</form>
	<script type="text/javascript" src="script.js"></script>
</body>
</html>