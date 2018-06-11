package persistencia;

import java.util.List;

import modelo.Disciplinas;
import modelo.Notas;

public interface DBTotal {

	int adicionaNota();
	List<Notas> listarNota();
	List<Disciplinas> listarDisciplina();
}
