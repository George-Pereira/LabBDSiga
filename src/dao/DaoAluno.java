package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
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
	public List<Aluno> listaDisciplina(String cod_disc)
	{
		List<Aluno> chamada = new LinkedList<Aluno>();
		String sql = "SELECT ra, nome FROM aluno INNER JOIN faltas ON aluno.ra = faltas.ra_aluno INNER JOIN disciplina ON faltas.codigo_disciplina WHERE disciplina.codigo = ?";
		PreparedStatement state;
		try 
		{
			state = c.prepareStatement(sql);
			state.setString(1, cod_disc);
			ResultSet result = state.executeQuery();
			while(result.next()) 
			{
				Aluno novo = new Aluno();
				novo.setRa(result.getString("ra"));
				novo.setNome(result.getString("nome"));
				chamada.add(novo);
			}
			result.close();
			state.close();
			c.close();
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		return chamada;
	}
}
