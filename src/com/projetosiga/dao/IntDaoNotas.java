package com.projetosiga.dao;

import java.sql.SQLException;

import com.projetosiga.entity.Notas;

public interface IntDaoNotas {

	public void inserirNota(Notas nota) throws SQLException;
}
