package com.projetosiga.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import com.projetosiga.entity.Faltas;

public class DaoFaltas 
{
	private Connection connect;
	public DaoFaltas()
	{
		IntDaoGenerica dao = new DaoGenerica();
		this.connect = dao.getConnection();
	}
	public void inserirFaltas(Faltas aluno) throws SQLException
	{
		String sql = "{CALL sp_insereFaltas(?,?,?,?)}";
		CallableStatement state = connect.prepareCall(sql);
		state.setString(1, aluno.getRa_aluno());
		state.setString(2, aluno.getCodigo_disciplina());
		state.setDate(3, aluno.getDia());
		state.setInt(4, aluno.getPresencas());
		state.execute();
		state.close();
	}
	public List<Faltas> construirRelatorio()
	{
		
		return null;
	}
}
