package com.projetosiga.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.projetosiga.entity.Notas;

public class DaoNotas implements IntDaoNotas {

	private Connection c;
	
	public DaoNotas() {
		IntDaoGenerica dao = new DaoGenerica();
		c = dao.getConnection();
	}
	
	public void inserirNota(Notas nota) throws SQLException {
		String sql = "{CALL sp_insereNota(?,?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, nota.getRa_aluno());
		cs.setString(2, nota.getCodigo_disciplina());
		cs.setInt(3, nota.getCodigo_avaliacao());
		cs.setDouble(4, nota.getNota());
		cs.setDouble(5, nota.getPeso());
		cs.execute();
		cs.close();
	}

	public void atualizaNota(Notas nota) throws SQLException {
		String sql = "UPDATE notas set nota = ?, peso = ? where ra_aluno = ? AND codigo_disciplina = ? AND codigo_avaliacao = ?";
		PreparedStatement stmt = c.prepareStatement(sql);
		stmt.setDouble(1, nota.getNota());
		stmt.setDouble(2, nota.getPeso());
		stmt.setString(3, nota.getRa_aluno());
		stmt.setString(4, nota.getCodigo_disciplina());
		stmt.setInt(5, nota.getCodigo_avaliacao());
		stmt.execute();
		stmt.close();
	}
	
}
