package modelo;

public class Nota {
	
	private Disciplinas disciplina;
	private Avaliacao avaliacao;
	private double nota;

	public Disciplinas getDisciplina() {
		return disciplina;
	}
	public void setDisciplina(Disciplinas disciplina) {
		this.disciplina = disciplina;
	}
	public double getNota() {
		return nota;
	}
	public void setNota(double nota) {
		this.nota = nota;
	}
}
