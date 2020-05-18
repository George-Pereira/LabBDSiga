package dao;

import java.sql.SQLException;
import java.util.List;

import entity.Avaliacao;

public interface IntDaoAvaliacao {

	public List<Avaliacao> getListaAvaliacao () throws SQLException;
}
