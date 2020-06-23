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
						Double SP1 = medias.get(0).getSP1(),
								SP2 = medias.get(0).getSP2(),
								SP3 = medias.get(0).getSP3(),
								ST = medias.get(0).getST(),
								SEF = medias.get(0).getSEF(),
								SPE = medias.get(0).getSPE(),
								SMC = medias.get(0).getSMC(),
								SMR = medias.get(0).getSMR();
						%>
						<table border="1" title="Relatório de Médias" >
							<thead>
								<tr align="center" style="padding:50px; border: 2px solid black; background-color: white;">
									<th><h2>RA</h2></th>
									<th><h2>Nome</h2></th>
									<%if(SP1 > 0) %><th><h2>P1</h2></th>
									<%if(SP2 > 0) %><th><h2>P2</h2></th>
									<%if(SP3 > 0) %><th><h2>P3</h2></th>
									<%if(ST > 0) %><th><h2>T</h2></th>
									<%if(SEF > 0) %><th><h2>Exame Final</h2></th>
									<%if(SPE > 0) %><th><h2>Pre Exame</h2></th>
									<%if(SMC > 0) %><th><h2>Monografia Completa</h2></th>
									<%if(SMR > 0) %><th><h2>Monografia Resumida</h2></th>
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
											<%if(SP1 > 0) {%><td width="90"><h3><%=media.getP1() %></h3></td><%} %>
											<%if(SP2 > 0) {%><td width="90"><h3><%=media.getP2() %></h3></td><%} %>
											<%if(SP3 > 0) {%><td width="90"><h3><%=media.getP3() %></h3></td><%} %>
											<%if(ST > 0) {%><td width="90"><h3><%=media.getT() %></h3></td><%} %>
											<%if(SEF > 0) {%><td width="90"><h3><%=media.getEF() %></h3></td><%} %>
											<%if(SPE > 0) {%><td width="90"><h3><%=media.getPE() %></h3></td><%} %>
											<%if(SMC > 0) {%><td width="90"><h3><%=media.getMC() %></h3></td><%} %>
											<%if(SMR > 0) {%><td width="90"><h3><%=media.getMR() %></h3></td><%} %>
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