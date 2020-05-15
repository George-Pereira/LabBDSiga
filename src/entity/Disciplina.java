package entity;

public class Disciplina 
{
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
