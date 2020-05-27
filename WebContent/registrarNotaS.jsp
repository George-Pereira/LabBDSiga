<%@page import="java.sql.SQLException"%>
<%@page import="com.projetosiga.dao.DaoAvaliacao"%>
<%@page import="com.projetosiga.entity.Avaliacao"%>
<%@page import="java.util.LinkedList"%>
<%@page import="com.projetosiga.entity.Aluno"%>
<%@page import="java.util.List"%>
<%@page import="com.projetosiga.dao.DaoAluno"%>
<%@page import="com.projetosiga.dao.IntDaoAluno"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
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
		  <li><a href="./registrarNota.jsp" class="active">Registrar Nota</a></li>
		  <li class="dropdown">
		    <a class="dropbtn">Relatórios</a>
		    <div class="dropdown-content">
		      <a href="./gerarMedias.jsp">Gerar Médias</a>
		      <a href="./gerarFaltas.jsp">Gerar Faltas</a>
		    </div>
  		  </li>
		</ul>
	</div>
	
	<% 
		String cod_disc = request.getParameter("codigo_disciplina");
		if (cod_disc == null) {
			cod_disc = request.getParameter("disciplina");
		}
		
		IntDaoAluno dao = new DaoAluno();
		List<Aluno> alunos = new LinkedList<Aluno>();
		alunos = dao.getListaAlunos(cod_disc);
		List<Avaliacao> listaAvaliacao = new LinkedList<Avaliacao>();
		DaoAvaliacao daoAvaliacao = new DaoAvaliacao();
		
		try {
			listaAvaliacao = daoAvaliacao.getListaAvaliacao();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	%>
	
	<div id="campos" align="center" style="padding:50px;">
		<form action="insereNota" method="post"> 
			<label for="nota">Disciplina</label> 
			<input type="text" id="codigo_disciplina" name="codigo_disciplina" required readonly value="<%= cod_disc %>"><br><br>
			<label for="ra_aluno">Nome do Aluno </label>
			<select id="ra_aluno" name="ra_aluno" required style="height: 25px; width: 250px;">
			<% 
			for (Aluno aluno : alunos) {
				%><option value="<%=aluno.getRa()%>"><%= aluno.getNome()%></option> 
			<%}%>
			</select><br><br>
			<label for="codigo_avaliacao">Código da Avaliação </label>
			<select id="codigo_avaliacao" name="codigo_avaliacao" required style="height: 30px; width: 80px;">
			<% 
			for (Avaliacao avaliacao : listaAvaliacao) {
				%><option value="<%=avaliacao.getCodigo()%>"><%= avaliacao.getTipo()%></option> 
			<%}%>
			</select><br><br> 
			<label for="nota">Nota </label> 
			<input type="number" autocomplete="off" step="any" id="nota" min="0" name="nota" required style="height: 30px; width: 80px;"><br> 
			<label for="peso">Peso </label> 
			<input type="number" autocomplete="off" step="any" id="peso" min="0" name="peso" required style="height: 30px; width: 80px;"><br>
			<input type="submit" value="Registrar">
		</form>
	</div>


	<script type="text/javascript" src="script.js"></script>
</body>
</html>