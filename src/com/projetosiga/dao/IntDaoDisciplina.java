package com.projetosiga.dao;

import java.sql.SQLException;
import java.util.List;

import com.projetosiga.entity.Disciplina;

public interface IntDaoDisciplina {

	public List<Disciplina> getListaDisciplinas () throws SQLException;
}
