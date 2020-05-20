function listaAlunosporDisciplina(cod_disciplina) {
	/*console.log(cod_disciplina);*/
	var disciplina = document.getElementById('campos').state.display = 'block';
	var cmpname= Packages.com.projetosiga.dao.DaoAluno.getListaAlunos();
}

function tdGanhaFoco (num) {
	document.getElementById('linha'+num).style.backgroundColor = "lightblue";
}

function tdPerdeFoco (num) {
	document.getElementById('linha'+num).style.backgroundColor = "white";
}



