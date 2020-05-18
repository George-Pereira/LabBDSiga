package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import entity.Aluno;

public class DaoAluno implements IntDaoAluno {

	private Connection c;
	
	public DaoAluno() {
		IntDaoGenerica dao = new DaoGenerica();
		c = dao.getConnection();
	}
	
	@Override
	public List<Aluno> getListaAlunos() throws SQLException {
		String sql = "SELECT * FROM aluno";
		Statement stmt = c.createStatement();
		ResultSet rs = stmt.executeQuery(sql);
		List<Aluno> listaAlunos = new LinkedList<Aluno>();
		while (rs.next()) {
			Aluno aluno = new Aluno();
			aluno.setRa(rs.getString("ra"));
			aluno.setNome(rs.getString("nome"));
			listaAlunos.add(aluno);
		}
		rs.close();
		stmt.close();
		Collections.sort(listaAlunos);
		return listaAlunos;
	}

}
