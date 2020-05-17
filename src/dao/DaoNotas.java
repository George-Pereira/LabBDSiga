package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import entity.Notas;

public class DaoNotas {

	private Connection c;
	
	public DaoNotas() {
		IntDaoGenerica dao = new DaoGenerica();
		c = dao.getConnection();
	}
	
	public void inserirNota(Notas nota) throws SQLException {
		String sql = "{CALL sp_insereNota(?,?,?,?)}";
		CallableStatement cs = c.prepareCall(sql);
		cs.setString(1, nota.getRa_aluno());
		cs.setString(2, nota.getCodigo_disciplina());
		cs.setInt(3, nota.getCodigo_avaliacao());
		cs.setDouble(4, nota.getNota());
		cs.execute();
		cs.close();
	}
	
	public static void main(String[] args) {
		DaoNotas dao = new DaoNotas();
		Notas nota = new Notas();
		nota.setRa_aluno("1110481812042");
		nota.setCodigo_disciplina("4203-010");
		nota.setCodigo_avaliacao(2);
		nota.setNota(7.2);
		try {
			dao.inserirNota(nota);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
