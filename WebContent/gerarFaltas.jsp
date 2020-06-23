
<%@page import="com.projetosiga.entity.Aluno_Faltas"%>
<%@page import="com.projetosiga.dao.DaoFaltas"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.projetosiga.dao.IntDaoDisciplina" %>
<%@ page import="com.projetosiga.entity.Disciplina"%>
<%@ page import="com.projetosiga.dao.DaoDisciplina"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import= "java.text.SimpleDateFormat"%>
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
	<form action="relatoriofaltas" method="post" target="_blank">
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
			<button type="submit" name="cmd" value="relatorioTela" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: 2px solid black; border-radius: 20px; width: 120px; height: 30px;">Mostrar em Tela</button>
			  <button type="submit" name="cmd" value="pdf" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: 2px solid black; border-radius: 20px; width: 120px; height: 30px;">Gerar PDF</button>
		</div>
	</form>
	<div style="padding-top: 50px" align="center">
		<% 
			String cod_disc = request.getParameter("disciplina");
			if(cod_disc != null)
			{
				DaoFaltas daoft = new DaoFaltas();
				List<Aluno_Faltas> lista = new ArrayList<Aluno_Faltas>();
				lista = daoft.construirRelatorio(cod_disc);
				SimpleDateFormat sdf = new SimpleDateFormat("dd-MM");
				if(!lista.isEmpty())
				{
					%>
					<table border="1" title="Relatório de Faltas" >
							<thead>
								<tr align="center" style="padding:50px; border: 2px solid black; background-color: white;">
									<th><h2>RA</h2></th>
									<th><h2>Nome</h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData1())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData2())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData3())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData4())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData5())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData6())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData7())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData8())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData9())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData10())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData11())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData12())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData13())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData14())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData15())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData16())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData17())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData18())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData19())%></h2></th>
									<th><h2><%=sdf.format(lista.get(1).getData20())%></h2></th>
									<th><h2>Total de Faltas</h2></th>
							</thead>
							<tbody>
					<% 
						for(Aluno_Faltas af : lista)
						{ 
						%>
							<tr class="tdRelatorio" align="center" style="background-color: white;">
							<td width="200"><h3><%=af.getRa()%></h3></td>
							<td width="300"><h3><%=af.getNome()%></h3></td>
							<td width="105"><h3><%=af.getPresenca1()%></h3></td>
							<td width="105"><h3><%=af.getPresenca2()%></h3></td>
							<td width="105"><h3><%=af.getPresenca3()%></h3></td>
							<td width="105"><h3><%=af.getPresenca4()%></h3></td>
							<td width="105"><h3><%=af.getPresenca5()%></h3></td>
							<td width="105"><h3><%=af.getPresenca6()%></h3></td>
							<td width="105"><h3><%=af.getPresenca7()%></h3></td>
							<td width="105"><h3><%=af.getPresenca8()%></h3></td>
							<td width="105"><h3><%=af.getPresenca9()%></h3></td>
							<td width="105"><h3><%=af.getPresenca10()%></h3></td>
							<td width="105"><h3><%=af.getPresenca11()%></h3></td>
							<td width="105"><h3><%=af.getPresenca12()%></h3></td>
							<td width="105"><h3><%=af.getPresenca13()%></h3></td>
							<td width="105"><h3><%=af.getPresenca14()%></h3></td>
							<td width="105"><h3><%=af.getPresenca15()%></h3></td>
							<td width="105"><h3><%=af.getPresenca16()%></h3></td>
							<td width="105"><h3><%=af.getPresenca17()%></h3></td>
							<td width="105"><h3><%=af.getPresenca18()%></h3></td>
							<td width="105"><h3><%=af.getPresenca19()%></h3></td>
							<td width="105"><h3><%=af.getPresenca20()%></h3></td>
							<td width="105"><h3><%=af.getTotal_faltas()%></h3></td>
						</tr>
					 <%}
					 %>
					</tbody>
					</table>
					<%
				}
				else
				{
					%>
					<div align="center" style="margin: 100px 300px;">
						<h1>NÃO HÁ ALUNOS MATRICULADOS NESTA DISCIPLINA!</h1><br>
						<button style="width: 100px; height: 50px" onclick="location.href='./gerarFaltas.jsp'">Voltar</button>
					</div>
					<%
				}
			}
		%>
	</div>
</html>