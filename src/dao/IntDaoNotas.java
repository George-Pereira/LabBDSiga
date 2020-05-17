package dao;

import java.sql.SQLException;

import entity.Notas;

public interface IntDaoNotas {

	public void inserirNota(Notas nota) throws SQLException;
}
