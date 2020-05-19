package dao;

import java.util.List;

import entity.Aluno;

public interface IntDaoAluno {

	public List<Aluno> getListaAlunos (String cod_disciplina);
	public List<Aluno> getTodosAlunos ();
}
