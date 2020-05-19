<%@page import="dao.IntDaoAluno"%>
<%@page import="entity.Disciplina"%>
<%@page import="entity.Aluno"%>
<%@page import="dao.DaoDisciplina"%>
<%@page import="dao.DaoAluno"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.List"%>
<%@page import="dao.IntDaoDisciplina" %>
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
		      <a class="active" href="./gerarMedias.jsp">Gerar Médias</a>
		      <a class="active" href="./gerarFaltas.jsp">Gerar Faltas</a>
		    </div>
  		  </li>
		</ul>
	</div>
	<div align="center" style="padding:50px;">
		<form action="inserirFaltas" method="post">
		<label for="disciplina">Disciplina</label>
		<select id="disciplina" name="disciplina" required style="height: 25px; width: 310px;"onchange="listaAlunosporDisciplina(document.getElementById('codigo_disciplina').value)">
		<% 
			List <Disciplina> listDisc = new LinkedList<Disciplina>();
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
	</div>
	<div>
		<table width="60%">
			
				<thead>
					<tr>
						<th>RA</th>
						<th>Nome</th>
						<th>Faltas</th>
					</tr>	
				</thead>
				<tbody>
						<%	IntDaoAluno al = new DaoAluno();
							List<Aluno> chamada = new LinkedList<Aluno>();
							chamada = al.getListaAlunos("4203-010");
							for(Aluno a : chamada)
							{ %>
							  <tr><%a.getRa();%></tr>	
						  <%}%>
				</tbody>
		</table>
	</div>
</body>
</html>