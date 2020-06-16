package com.projetosiga.dao;

import java.sql.SQLException;
import java.util.List;

import com.projetosiga.entity.Avaliacao;

public interface IntDaoAvaliacao {

	public List<Avaliacao> getListaAvaliacao (String codDisciplina) throws SQLException;
}
