package modelo;

public class TabelaNotas {
	
	private Aluno aluno;	
	private double nota1;
	private double nota2;
	private double nota3;
	private double media;
	private double preexame;
	private double notaP3;
	private String situacao;
	
	public double getPreexame() {
		return preexame;
	}
	public void setPreexame(double preexame) {
		this.preexame = preexame;
	}
	public double getNotaP3() {
		return notaP3;
	}
	public void setNotaP3(double notaP3) {
		this.notaP3 = notaP3;
	}
	public double getNota1() {
		return nota1;
	}
	public void setNota1(double nota1) {
		this.nota1 = nota1;
	}
	public double getNota2() {
		return nota2;
	}
	public void setNota2(double nota2) {
		this.nota2 = nota2;
	}
	public double getNota3() {
		return nota3;
	}
	public void setNota3(double nota3) {
		this.nota3 = nota3;
	}
	public double getMedia() {
		return media;
	}
	public void setMedia(double media) {
		this.media = media;
	}
	public String getSituacao() {
		return situacao;
	}
	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}
	public Aluno getAluno() {
		return aluno;
	}
	public void setAluno(Aluno aluno) {
		this.aluno = aluno;
	}
}
