package com.projetosiga.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import com.projetosiga.entity.Disciplina;

public class DaoDisciplina implements IntDaoDisciplina {

	private Connection c;
	
	public DaoDisciplina() {
		IntDaoGenerica dao = new DaoGenerica();
		c = dao.getConnection();
	}
	
	public List<Disciplina> getListaDisciplinas () throws SQLException {
		String sql = "SELECT * FROM disciplina ORDER BY disciplina.nome";
		Statement stmt = c.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		List<Disciplina> listaDisciplinas = new LinkedList<Disciplina>();
		while (rs.next()) {
			Disciplina disciplina = new Disciplina();
			disciplina.setCodigo(rs.getString("codigo"));
			disciplina.setNome(rs.getString("nome"));
			disciplina.setSigla(rs.getString("sigla"));
			disciplina.setTurno(rs.getString("turno"));
			disciplina.setNaulas(rs.getInt("num_aulas"));
			listaDisciplinas.add(disciplina);
		}
		rs.close();
		stmt.close();
		return listaDisciplinas;
	}
}
