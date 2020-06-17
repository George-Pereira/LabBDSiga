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
			  <input type="submit" value="Gerar Relatório" style="color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: none; border-radius: 20px">
		</form> 
	</div>
</body>
</html>