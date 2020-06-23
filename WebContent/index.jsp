<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="./style.css">
	<title>Siga - Home</title>
</head>
<body>
	<header>
		<div class="navBar">
			<ul>
			  <li><img alt="" src="./img/logosiga.png" id="logo"></li>
			  <li><a class="active" href="#home">Home</a></li>
			  <li><a href="./selchamada.jsp">Chamada</a></li>
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
	</header>
</body>
	<div align="center">
		<p><a href="//www.saopaulo.sp.gov.br/" target="_blank"><img alt="image" src="./img/brasao.png" id="brasaosp" height="200px" width="200px"></a>
		<a href="//www.cps.sp.gov.br/" target="_blank"><img alt="image" src="./img/cpslogotrans.png" id="logocps" height="200px" width="225px"></a>
		</p>
	</div>
</html>