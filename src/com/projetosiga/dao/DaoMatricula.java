package com.projetosiga.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class DaoMatricula {

	private Connection c;
	
	public DaoMatricula() {
		IntDaoGenerica dao = new DaoGenerica();
		c = dao.getConnection();
	}
	
	public void insereMatricula(String cod_disc, String ra) throws SQLException {
		String sql = "INSERT INTO matricula (ra_aluno, codigo_disciplina) VALUES('"+ra+"', '"+cod_disc+"')";
		Statement stmt = c.createStatement();
		stmt.execute(sql);
		stmt.close();
	}
}
