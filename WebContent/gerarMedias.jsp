<%@page import="java.util.ArrayList"%>
<%@page import="com.projetosiga.entity.Media"%>
<%@page import="com.projetosiga.dao.DaoNotas"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.projetosiga.dao.DaoDisciplina"%>
<%@page import="com.projetosiga.entity.Disciplina"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="./style.css">
	<title>Siga - Relatório de Médias</title>
</head>
<body>
	<div class="navBar">
		<ul>
		  <li><img alt="" src="./img/logosiga.png" id="logo"></li>
		  <li><a href="./index.jsp">Home</a></li>
		  <li><a href="./selchamada.jsp">Chamada</a></li>
		  <li><a href="./registrarNota.jsp">Registrar Nota</a></li>
		  <li class="dropdown">
		    <a class="dropbtn active">Relatórios</a>
		    <div class="dropdown-content">
		      <a class="active" href="./gerarMedias.jsp">Gerar Médias</a>
		      <a href="./gerarFaltas.jsp">Gerar Faltas</a>
		    </div>
  		  </li>
		</ul>
	</div>
	
	<div align="center" style="padding:50px;">
		<form action="relatorioMedias" method="post" target="_ blank">
			  <label for="codigo_disciplina">Disciplina </label>
			  <select id="codigo_disciplina" style="border-radius: 12px; border: none; color: white; background-color: gray; height: 25px;" name="codigo_disciplina" required style="height: 25px; width: 310px;">
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
			  <button type="submit" name="cmd" value="relatorioTela" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: 2px solid black; border-radius: 20px; width: 120px; height: 30px;">Mostrar em Tela</button>
			  <button type="submit" name="cmd" value="relatorioPDF" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: 2px solid black; border-radius: 20px; width: 120px; height: 30px;">Gerar PDF</button>
		</form> 
		
		<div style="padding-top: 50px;" align="center">
			<%
				String cod_disc = request.getParameter("disciplina");
				if (cod_disc != null){
					DaoNotas daoNotas = new DaoNotas();
					List<Media> medias = new ArrayList<Media>();
					medias = daoNotas.relatorioMedias(cod_disc);
					if (!medias.isEmpty()) {
						%>
						<table border="1" title="Relatório de Médias" >
							<thead>
								<tr align="center" style="padding:50px; border: 2px solid black; background-color: white;">
									<th><h2>RA</h2></th>
									<th><h2>Nome</h2></th>
									<th><h2>Nota 1</h2></th>
									<th><h2>Nota 2</h2></th>
									<th><h2>Nota 3</h2></th>
									<th><h2>Média</h2></th>
									<th><h2>Situação</h2></th>
							</thead>
							<tbody>
							<%
								for (Media media : medias) {
									%>
										<tr class="tdRelatorio" align="center" style="background-color: white;">
											<td width="200"><h3><%=media.getRA() %></h3></td>
											<td width="350"><h3><%=media.getNomeAluno() %></h3></td>
											<td width="90"><h3><%=media.getNota1() %></h3></td>
											<td width="90"><h3><%=media.getNota2() %></h3></td>
											<td width="90"><h3><%=media.getNota3() %></h3></td>
											<td width="90"><h3><%=media.getMedia() %></h3></td>
											<td width="140"><h3><%=media.getSituacao() %></h3></td>
										</tr>
									<%
								}
						 
							%>
							</tbody>
						</table>
						<%
					} else {
						%>
						<div align="center" style="margin: 100px 300px;">
							<h1>NÃO HÁ ALUNOS MATRICULADOS NESTA DISCIPLINA!</h1><br>
							<button style="width: 100px; height: 50px" onclick="location.href='./gerarMedias.jsp'">Voltar</button>
						</div>
						<%
					}
				 }
			%>
		</div>
	</div>
</body>
</html>