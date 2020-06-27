package com.projetosiga.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;

import com.projetosiga.entity.Aluno;

public class DaoAluno implements IntDaoAluno {

	private Connection c;
	
	public DaoAluno() {
		IntDaoGenerica dao = new DaoGenerica();
		c = dao.getConnection();
	}
	
	public List<Aluno> getListaAlunos(String cod_disciplina) {
		List<Aluno> lista = new LinkedList<Aluno>();
		String sql = "SELECT a.ra, a.nome FROM matricula m "
				+ "inner join aluno a on a.ra = m.ra_aluno "
				+ "inner join disciplina d on d.codigo = m.codigo_disciplina WHERE d.codigo = ?";
		PreparedStatement state;
		try
		{
			state = c.prepareStatement(sql);
			state.setString(1, cod_disciplina);
			ResultSet result = state.executeQuery();
			while(result.next()) 
			{
				Aluno novo = new Aluno();
				novo.setRa(result.getString("ra"));
				novo.setNome(result.getString("nome"));
				lista.add(novo);
			}
			result.close();
			state.close();
			c.close();
		}
		catch (SQLException e) 
		{
			e.printStackTrace();
		}
		Collections.sort(lista);
		return lista;
	}
	public List<Aluno> getTodosAlunos() {
		List<Aluno> chamada = new LinkedList<Aluno>();
		String sql = "SELECT * from aluno";
		PreparedStatement state;
		try 
		{
			state = c.prepareStatement(sql);
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
		Collections.sort(chamada);
		return chamada;
	}

	@Override
	public void insereAluno(Aluno al) throws SQLException 
	{
		String sql = "INSERT INTO aluno (ra, nome) VALUES(?,?)";
		PreparedStatement stmt = c.prepareStatement(sql);
		stmt.setString(1, al.getRa());
		stmt.setString(2, al.getNome());
		stmt.execute();
		stmt.close();
		c.close();
	}
}
