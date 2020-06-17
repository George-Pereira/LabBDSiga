<%@page import="java.sql.SQLException"%>
<%@page import="com.projetosiga.dao.DaoDisciplina"%>
<%@page import="com.projetosiga.entity.Disciplina"%>
<%@page import="java.util.List"%>
<%@page import="com.projetosiga.entity.Aluno"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.projetosiga.dao.IntDaoAluno"%>
<%@page import="com.projetosiga.dao.DaoAluno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Siga - Chamada</title>
<link rel="stylesheet" type="text/css" href="./style.css">
</head>
<body>
	<div class="navBar">
		<ul>
		  <li><img alt="" src="./img/logosiga.png" id="logo"></li>
		  <li><a href="./index.jsp">Home</a></li>
		  <li><a href="./selchamada.jsp" class="active">Chamada</a></li>
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
	<div>
		<%	String cod_disc = request.getParameter("disciplina");
			String dt = request.getParameter("data");
			dt = dt.substring(8,10)+"/"+dt.substring(5,7)+"/"+dt.substring(0,4);
			IntDaoAluno dao = new DaoAluno();
			List<Aluno> chamada = new LinkedList<Aluno>();
			try
			{
				chamada = dao.getListaAlunos(cod_disc);
				Disciplina disciplina = new Disciplina();
				DaoDisciplina daoDisciplina = new DaoDisciplina();
				try 
				{
					disciplina = daoDisciplina.getDisciplinaPorCod(cod_disc);
				}
				catch (SQLException e1) 
				{
					e1.printStackTrace();
				}
				if(!chamada.isEmpty())
				{
					%><div align="center" class="tabelaChamada">
						<form action="insereFaltas" method="post">
							<table>
								<thead>
									<tr align="center" style="padding:50px">
										<th>RA</th>
										<th>Nome</th>
										<th>Faltas</th>
								</thead>
								<tbody>
								<% 
								int td = 1;
								for(Aluno a : chamada) 
								{
								%>
									<tr align="center" id="linha<%=td%>" style="background-color: white;">
										<td><input type="text" id="raAluno<%=td%>" name="raAluno<%=td%>" required readonly value="<%=a.getRa()%>"></td>
										<td><%=a.getNome()%></td>
										<td>
										<% 
										if (disciplina.getNaulas() != 40)
										{%>
											<input type="checkbox" checked value="1" name="presencaLinha<%=td%>" id="presencaLinha<%=td%>" onchange="tdGanhaFoco(<%=td%>)" onblur="tdPerdeFoco(<%=td%>)">
											<input type="checkbox" checked value="1" name="presencaLinha<%=td%>" id="presencaLinha<%=td%>" onchange="tdGanhaFoco(<%=td%>)" onblur="tdPerdeFoco(<%=td%>)">
										<%
										}
										%>
											<input type="checkbox" checked value="1" name="presencaLinha<%=td%>" id="presencaLinha<%=td%>" onchange="tdGanhaFoco(<%=td%>)" onblur="tdPerdeFoco(<%=td%>)">
											<input type="checkbox" checked value="1" name="presencaLinha<%=td%>" id="presencaLinha<%=td%>" onchange="tdGanhaFoco(<%=td%>)" onblur="tdPerdeFoco(<%=td%>)">
										</td>
									</tr>
								<%
								td++;
								}
							td--;%>
						</tbody>
					</table>
				<input type="text" id="codigo_disciplina" name="codigo_disciplina" readonly style="display: none" value="<%=cod_disc%>"/><br>
				<input type="text" id="quantidadeAlunos" name="quantidadeAlunos" readonly style="display: none" value="<%=td%>"/><br>
				<input type="text" id="data" name="data" readonly value="<%=dt%>"/><br><br>
				<input type="submit" value="Registrar Faltas" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: none; border-radius: 20px">
			</form>
		</div>
		<%
				}
				else
				{
					%><div  align="center" style="margin: 100px 300px;"><h1>NÃO HÁ ALUNOS MATRICULADOS NESTA DISCIPLINA!</h1>
					<br><button style="width: 100px; height: 50px" onclick="location.href='./selchamada.jsp'">Voltar</button></div><%
				}
			}
			catch(Exception e)
			{
				e.printStackTrace();
			}
		%>
	</div>
	<script type="text/javascript" src="./script.js"></script>
	
</body>
</html>