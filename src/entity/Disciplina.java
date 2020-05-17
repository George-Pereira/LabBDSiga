package entity;

public class Disciplina 
{
	private String codigo;
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
	private String nome;
	private String sigla;
	private String turno;
	private int Naulas;
	
	public Disciplina(String nome, String sigla, String turno, int Naulas) 
	{
		this.nome = nome;
		this.sigla = sigla;
		this.turno = turno;
		this.Naulas = Naulas;
	}
	public Disciplina() 
	{
	}
}
