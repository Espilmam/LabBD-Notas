package controle;

import java.util.List;

import modelo.Aluno;
import modelo.Disciplinas;
import modelo.TabelaFaltas;
import modelo.TabelaNotas;
import persistencia.DBTotal;
import persistencia.DBTotalImpl;

public class ControleDisciplinas {

	DBTotal db = new DBTotalImpl();
	public String adicionaAluno(Aluno aluno) {
		return db.adicionaAluno(aluno);
	}

	public String adicionaNota(Aluno aluno) {
		return db.adicionaNota(aluno);
	}

	public String adicionaFalta(Aluno aluno) {
		return db.adicionaFalta(aluno);
	}

	public List<TabelaNotas> listarNotas(Disciplinas disciplina) {
		return db.listarNota(disciplina);
	}

	public List<TabelaFaltas> listarFaltas(Disciplinas disciplina) {
		return db.listarFaltas(disciplina);
	}
}
