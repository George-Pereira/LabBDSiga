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
		      <a class="active" href="./gerarMedias.jsp">Gerar Médias</a>
		      <a class="active" href="./gerarFaltas.jsp">Gerar Faltas</a>
		    </div>
  		  </li>
		</ul>
	</div>
	<form action="insereFaltas" method="post">
		<div align="center" style="padding:50px;">
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
			<%
			Date hoje = new Date();
			Calendar cal = Calendar.getInstance();
			cal.setTime(hoje);
			int ano = cal.get(Calendar.YEAR);
			String mes = String.valueOf(cal.get(Calendar.MONTH) + 1);
			if (mes.length() < 2 ) {
				mes = "0"+mes;
			}
<<<<<<< HEAD
		%>
		</select><br>
	</div>
	<div align="center">
		<table width="100%">
=======
			int dia = cal.get(Calendar.DAY_OF_MONTH);
			%>
			<label for="data">Data</label>
			<input id="data" name="data" type="date" value="<%=ano %>-<%=mes %>-<%=dia %>">
		</div>
		<div align="center">
			<table width="60%">
>>>>>>> branch 'master' of https://www.github.com/George-Pereira/LabBDSiga
				<thead>
					<tr align="center" style="padding:50px">
						<th>RA</th>
						<th>Nome</th>
						<th>Faltas</th>
					</tr>	
				</thead>
						<%	IntDaoAluno al = new DaoAluno();
							List<Aluno> chamada = new LinkedList<Aluno>();
							chamada = al.getTodosAlunos();
							int td = 0;
							for(Aluno a : chamada)
<<<<<<< HEAD
							{ %>
							  <tr align="center" width="80"><td><%=a.getRa()%></td>
							  <td><%=a.getNome()%></td></tr>
=======
							{
							td++; %>
							<tr align="center" id="linha<%=td %>">
							  <td><%=a.getRa() %></td>
							  <td><%=a.getNome() %></td>
							  <td>
							  		<input type="checkbox" id="presenca1" name="presenca4" value="1" onfocus="tdGanhaFoco(<%=td %>)" onblur="tdPerdeFoco(<%=td %>)">
							  		<input type="checkbox" id="presenca2" name="presenca4" value="1" onfocus="tdGanhaFoco(<%=td %>)" onblur="tdPerdeFoco(<%=td %>)">
							  		<input type="checkbox" id="presenca3" name="presenca4" value="1" onfocus="tdGanhaFoco(<%=td %>)" onblur="tdPerdeFoco(<%=td %>)">
							  		<input type="checkbox" id="presenca4" name="presenca4" value="1" onfocus="tdGanhaFoco(<%=td %>)" onblur="tdPerdeFoco(<%=td %>)">
							  </td>
							</tr>
>>>>>>> branch 'master' of https://www.github.com/George-Pereira/LabBDSiga
						  <%}%>
<<<<<<< HEAD
		</table>
	</div>
=======
				</tbody>
			</table>
		</div>
	</form>
	
	
	
	
	<script type="text/javascript" src="script.js"></script>
>>>>>>> branch 'master' of https://www.github.com/George-Pereira/LabBDSiga
</body>
</html>