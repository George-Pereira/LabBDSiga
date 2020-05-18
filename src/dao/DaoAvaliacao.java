package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

import entity.Aluno;
import entity.Avaliacao;

public class DaoAvaliacao implements IntDaoAvaliacao {

private Connection c;
	
	public DaoAvaliacao() {
		IntDaoGenerica dao = new DaoGenerica();
		c = dao.getConnection();
	}

	@Override
	public List<Avaliacao> getListaAvaliacao() throws SQLException {
		String sql = "SELECT * FROM avaliacao";
		Statement stmt = c.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
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
