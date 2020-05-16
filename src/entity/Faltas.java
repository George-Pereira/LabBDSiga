package entity;

import java.sql.Date;

public class Faltas {
	private String ra_aluno;
	private String codigo_disciplina;
	private Date dia;
	private int presencas;
	
	public String getRa_aluno() {
		return ra_aluno;
	}
	public void setRa_aluno(String ra_aluno) {
		this.ra_aluno = ra_aluno;
	}
	public String getCodigo_disciplina() {
		return codigo_disciplina;
	}
	public void setCodigo_disciplina(String codigo_disciplina) {
		this.codigo_disciplina = codigo_disciplina;
	}
	public Date getDia() {
		return dia;
	}
	public void setDia(Date dia) {
		this.dia = dia;
	}
	public int getPresencas() {
		return presencas;
	}
	public void setPresencas(int presencas) {
		this.presencas = presencas;
	}
}
