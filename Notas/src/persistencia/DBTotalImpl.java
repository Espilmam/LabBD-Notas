package persistencia;

import java.sql.Connection;
import java.util.List;

import modelo.Disciplinas;
import modelo.Notas;

public class DBTotalImpl implements DBTotal {
	
	@Override
	public int adicionaNota() {
		
		Connection con = GenericDAO.getInstance().getConnection();
		
		return 0;	
	}
	@Override
	public List<Notas> listarNota() {
		
		Connection con = GenericDAO.getInstance().getConnection();
		
		return null;	
	}
	@Override
	public List<Disciplinas> listarDisciplina() {
		
		Connection con = GenericDAO.getInstance().getConnection();
		String query = "";
		
		return;
	}
}
