function listaAlunosporDisciplina(cod_disciplina) {
	document.getElementById('campos').style.display = 'block';
	console.log(cod_disciplina);
	var cmpname= Packages.com.projetosiga.dao.DaoAluno.getListaAlunos(cod_disciplina);
}

function tdGanhaFoco (num) {
	document.getElementById('linha'+num).style.backgroundColor = "lightblue";
}

function tdPerdeFoco (num) {
	document.getElementById('linha'+num).style.backgroundColor = "white";
}


