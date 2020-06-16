package com.projetosiga.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.projetosiga.entity.Avaliacao;

public class DaoAvaliacao implements IntDaoAvaliacao {

private Connection c;
	
	public DaoAvaliacao() {
		IntDaoGenerica dao = new DaoGenerica();
		c = dao.getConnection();
	}

	@Override
	public List<Avaliacao> getListaAvaliacao(String codDisciplina) throws SQLException {
		String sql = "select a.codigo, a.tipo from avaliacao a "
				+ "inner join disciplina_avaliacao da on da.cod_avaliacao = a.codigo "
				+ "inner join disciplina d on d.codigo = da.cod_disciplina "
				+ "where da.cod_disciplina = ?";
		PreparedStatement stmt = c.prepareStatement(sql);
		stmt.setString(1, codDisciplina);
		ResultSet rs = stmt.executeQuery();
		List<Avaliacao> listaAvaliacao = new LinkedList<Avaliacao>();
		while (rs.next()) {
			Avaliacao avaliacao = new Avaliacao();
			avaliacao.setCodigo(rs.getInt("codigo"));
			avaliacao.setTipo(rs.getString("tipo"));
			listaAvaliacao.add(avaliacao);
		}
		rs.close();
		stmt.close();
		return listaAvaliacao;
	}
	
	
}
