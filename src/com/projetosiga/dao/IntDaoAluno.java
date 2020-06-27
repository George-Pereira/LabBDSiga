package com.projetosiga.dao;

import java.sql.SQLException;
import java.util.List;

import com.projetosiga.entity.Aluno;

public interface IntDaoAluno {

	public List<Aluno> getListaAlunos (String cod_disciplina);
	public List<Aluno> getTodosAlunos ();
	public void insereAluno(Aluno al) throws SQLException;
}
