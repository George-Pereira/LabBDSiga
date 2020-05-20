package com.projetosiga.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import com.projetosiga.entity.Aluno;
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
		Date presenca = new Date();
		java.sql.Date sqldate = new java.sql.Date(presenca.getTime());
		state.setDate(1, sqldate);
		state.setInt(4, aluno.getPresencas());
		state.execute();
		state.close();
	}
}
