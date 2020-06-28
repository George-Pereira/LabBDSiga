package com.projetosiga.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import com.projetosiga.entity.Aluno_Faltas;
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
	
	public void atualizarFaltas(Faltas aluno) {
		try {
			String sql = "{CALL sp_atualizaFaltas(?,?,?,?)}";
			CallableStatement state = connect.prepareCall(sql);
			state.setString(1, aluno.getRa_aluno());
			state.setString(2, aluno.getCodigo_disciplina());
			state.setDate(3, aluno.getDia());
			state.setInt(4, aluno.getPresencas());
			state.execute();
			state.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public List<Aluno_Faltas> construirRelatorio(String cod_disc) throws SQLException
	{
		String sql = "SELECT * FROM fn_relatorioFaltas(?)";
		PreparedStatement pst = connect.prepareStatement(sql);
		pst.setString(1, cod_disc);
		ResultSet rs = pst.executeQuery();
		List<Aluno_Faltas> lista = new LinkedList<Aluno_Faltas>();
		while(rs.next()) 
		{
			Aluno_Faltas af = new Aluno_Faltas();
			af.setRa(rs.getString("ra_aluno"));
			af.setNome(rs.getString("nome_aluno"));
			af.setData1(rs.getDate("aula1"));
			af.setData2(rs.getDate("aula2"));
			af.setData3(rs.getDate("aula3"));
			af.setData4(rs.getDate("aula4"));
			af.setData5(rs.getDate("aula5"));
			af.setData6(rs.getDate("aula6"));
			af.setData7(rs.getDate("aula7"));
			af.setData8(rs.getDate("aula8"));
			af.setData9(rs.getDate("aula9"));
			af.setData10(rs.getDate("aula10"));
			af.setData11(rs.getDate("aula11"));
			af.setData12(rs.getDate("aula12"));
			af.setData13(rs.getDate("aula13"));
			af.setData14(rs.getDate("aula14"));
			af.setData15(rs.getDate("aula15"));
			af.setData16(rs.getDate("aula16"));
			af.setData17(rs.getDate("aula17"));
			af.setData18(rs.getDate("aula18"));
			af.setData19(rs.getDate("aula19"));
			af.setData20(rs.getDate("aula20"));
			af.setPresenca1(rs.getString("presencas1"));
			af.setPresenca2(rs.getString("presencas2"));
			af.setPresenca3(rs.getString("presencas3"));
			af.setPresenca4(rs.getString("presencas4"));
			af.setPresenca5(rs.getString("presencas5"));
			af.setPresenca6(rs.getString("presencas6"));
			af.setPresenca7(rs.getString("presencas7"));
			af.setPresenca8(rs.getString("presencas8"));
			af.setPresenca9(rs.getString("presencas9"));
			af.setPresenca10(rs.getString("presencas10"));
			af.setPresenca11(rs.getString("presencas11"));
			af.setPresenca12(rs.getString("presencas12"));
			af.setPresenca13(rs.getString("presencas13"));
			af.setPresenca14(rs.getString("presencas14"));
			af.setPresenca15(rs.getString("presencas15"));
			af.setPresenca16(rs.getString("presencas16"));
			af.setPresenca17(rs.getString("presencas17"));
			af.setPresenca18(rs.getString("presencas18"));
			af.setPresenca19(rs.getString("presencas19"));
			af.setPresenca20(rs.getString("presencas20"));
			af.setTotal_faltas(rs.getInt("tot_faltas"));
			af.setNome_disc(rs.getString("nome_disc"));
			lista.add(af);
		}
		return lista;
	}
}