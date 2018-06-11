package controle;

import java.util.List;

import modelo.Disciplinas;
import modelo.Notas;
import persistencia.DBTotalImpl;

public class ControleTotal {
	
	DBTotalImpl bd = new DBTotalImpl();
	
	public int adicionarNota() {
		
		return 0;
	}
	public List<Notas> listarNota() {
		
		return 0;
	}
	public List<Disciplinas> listarDisciplina() {
		
		return bd.recebeDisciplina();
	}

}
