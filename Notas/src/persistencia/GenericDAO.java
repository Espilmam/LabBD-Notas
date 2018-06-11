package persistencia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class GenericDAO {
	
	private static GenericDAO instancia;
	private Connection con;
	
	public GenericDAO() {
		
		try {
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:jtds:sqlserver://127.0.0.1:1433;DatabaseName=Notas;namedPipes=true;user=;password=");
			System.out.println("logado");
		} 
		catch (SQLException e) {
			
			e.printStackTrace();
		}
		catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
	}
	public static GenericDAO getInstance() {
		
		if (instancia == null) {
			
			instancia = new GenericDAO();
		}
		return instancia;
	}
	public Connection getConnection() {
		
		return con;
	}
}

