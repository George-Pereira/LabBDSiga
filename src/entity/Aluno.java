package entity;

public class Aluno implements Comparable<Aluno>{
	private String ra;
	private String nome;
	
	public String getRa() {
		return ra;
	}
	
	public void setRa(String ra) {
		this.ra = ra;
	}
	
	public String getNome() {
		return nome;
	}
	
	public void setNome(String nome) {
		this.nome = nome;
	}

	@Override
	public int compareTo(Aluno o) {
		return this.getNome().compareTo(o.getNome());
	}
}
