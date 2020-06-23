package com.projetosiga.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.projetosiga.entity.Media;
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
	
	public List<Media> relatorioMedias(String cod_disc) throws SQLException {
		String sql = "SELECT * from fn_Notas(?) order by Nome_Aluno";
		PreparedStatement stmt = c.prepareStatement(sql);
		stmt.setString(1, cod_disc);
		ResultSet rs = stmt.executeQuery();
		List<Media> lst = new ArrayList<Media>();
		while(rs.next()) {
			Media m = new Media();
			m.setRA(rs.getString(1));
			m.setNomeAluno(rs.getString(2));
			m.setP1(rs.getDouble(3));
			m.setP2(rs.getDouble(4));
			m.setP3(rs.getDouble(5));
			m.setT(rs.getDouble(6));
			m.setEF(rs.getDouble(7));
			m.setPE(rs.getDouble(8));
			m.setMC(rs.getDouble(9));
			m.setMR(rs.getDouble(10));
			m.setMedia(rs.getDouble(11));
			m.setSituacao(rs.getString(12));
			m.setSP1(rs.getDouble(14));
			m.setSP2(rs.getDouble(15));
			m.setSP3(rs.getDouble(16));
			m.setST(rs.getDouble(17));
			m.setSEF(rs.getDouble(18));
			m.setSPE(rs.getDouble(19));
			m.setSMC(rs.getDouble(20));
			m.setSMR(rs.getDouble(21));
			lst.add(m);
		}
		stmt.close();
		rs.close();
		return lst;
	}
	
}
