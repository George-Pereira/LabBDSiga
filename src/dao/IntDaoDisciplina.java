package dao;

import java.sql.SQLException;
import java.util.List;

import entity.Disciplina;

public interface IntDaoDisciplina {

	public List<Disciplina> getListaDisciplinas () throws SQLException;
}
