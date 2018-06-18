package modelo;

public class Aluno {
	
	private int ra;
	private String nome;
	private Nota nota;
	private Falta falta;
	private Avaliacao av;

	public Nota getNota() {
		return nota;
	}
	public void setNota(Nota nota) {
		this.nota = nota;
	}
	public Falta getFalta() {
		return falta;
	}
	public void setFalta(Falta falta) {
		this.falta = falta;
	}
	public int getRa() {
		return ra;
	}
	public void setRa(int ra) {
		this.ra = ra;
	}
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public Avaliacao getAv() {
		return av;
	}
	public void setAv(Avaliacao av) {
		this.av = av;
	}
}
