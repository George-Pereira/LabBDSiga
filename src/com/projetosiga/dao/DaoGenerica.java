package com.projetosiga.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DaoGenerica implements IntDaoGenerica
{
	private Connection conexao;

	@Override
	public Connection getConnection() 
	{
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			conexao = DriverManager.getConnection("jdbc:jtds:sqlserver://127.0.0.1:1433;DatabaseName=db_SIGA;namedPipes=True");
		}
		catch (ClassNotFoundException | SQLException e) 
		{
			e.printStackTrace();
		}
		return conexao;
	}
}
