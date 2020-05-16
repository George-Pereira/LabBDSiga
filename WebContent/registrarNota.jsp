<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
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
		  <li><a href="./chamada.jsp">Chamada</a></li>
		  <li><a href="#" class="active">Registrar Nota</a></li>
		  <li class="dropdown">
		    <a class="dropbtn">Relatórios</a>
		    <div class="dropdown-content">
		      <a href="./gerarMedias.jsp">Gerar Médias</a>
		      <a href="./gerarFaltas.jsp">Gerar Faltas</a>
		    </div>
  		  </li>
		</ul>
	</div>
	
	<div align="center" style="padding:50px;">
		<form action="insereNota" method="post">
			  <label for="fra">RA do Aluno </label>
			  <input type="text" id="ra_aluno"><br>
			  <label for="fcod">Código da Disciplina </label>
			  <input type="text" id="codigo_disciplina"><br>
			  <label for="fcod">Código da Avaliação </label>
			  <input type="number" id="codigo_avaliacao"><br>
			  <label for="fnota">Nota </label>
			  <input type="number" id="nota"><br>
			  <input type="submit" value="Registrar">
		</form> 
	</div>
	
</body>
</html>