package entity;

public class Notas {
	
	private String ra_aluno;
	private String codigo_disciplina;
	private int codigo_avaliacao;
	private double nota;
	private double peso;
	
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
	public int getCodigo_avaliacao() {
		return codigo_avaliacao;
	}
	public void setCodigo_avaliacao(int codigo_avaliacao) {
		this.codigo_avaliacao = codigo_avaliacao;
	}
	public double getNota() {
		return nota;
	}
	public void setNota(double nota) {
		this.nota = nota;
	}
}
