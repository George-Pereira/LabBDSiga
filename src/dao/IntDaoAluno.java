package dao;

import java.sql.SQLException;
import java.util.List;

import entity.Aluno;

public interface IntDaoAluno {

	public List<Aluno> getListaAlunos () throws SQLException;
}
