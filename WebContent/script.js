function listaAlunosporDisciplina(cod_disciplina) {
	document.getElementById('campos').style.display = 'block';
	var dao = Java.type("/java_resources/src/dao.DaoAluno");
	var aluno = Java.type("/src/entity.Aluno");
	const list = new LinkedList();
	list = dao.getListaAlunos(cod_disciplina);
	while (list.next) {
		console.log(list.get(1))
	}
}