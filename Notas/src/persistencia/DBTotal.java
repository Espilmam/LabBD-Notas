package persistencia;

import java.util.List;

import modelo.Aluno;
import modelo.Disciplinas;
import modelo.TabelaFaltas;
import modelo.TabelaNotas;

public interface DBTotal {

	String adicionaNota(Aluno aluno);
	String adicionaFalta(Aluno aluno);
	String adicionaAluno(Aluno aluno);
	List<TabelaNotas> listarNota(Disciplinas disciplina);
	List<TabelaFaltas> listarFaltas(Disciplinas disciplina);
}
