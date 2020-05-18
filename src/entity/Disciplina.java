package entity;

public class Disciplina implements Comparable<Disciplina> {
	
	private String codigo;
	private String nome;
	private String sigla;
	private String turno;
	private int Naulas;
	
	public String getCodigo() {
		return codigo;
	}
	
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	
	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}
	
	public String getSigla() {
		return sigla;
	}
	
	public void setSigla(String sigla) {
		this.sigla = sigla;
	}
	
	public String getTurno() {
		return turno;
	}
	
	public void setTurno(String turno) {
		this.turno = turno;
	}
	
	public int getNaulas() {
		return Naulas;
	}
	
	public void setNaulas(int naulas) {
		Naulas = naulas;
	}
	
	@Override
	public String toString() {
		return this.nome+" - "+this.turno;
	}
	
	@Override
	public int compareTo(Disciplina o) {
		return this.toString().compareTo(o.toString());
	}
}
