package persistencia;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import modelo.Aluno;
import modelo.Disciplinas;
import modelo.TabelaFaltas;
import modelo.TabelaNotas;

public class DBTotalImpl implements DBTotal {
	
	@Override
	public List<TabelaNotas> listarNota(Disciplinas disciplina) {
		
		Connection con = GenericDAO.getInstance().getConnection();
		String query = "select * from fn_recebenotas(?)";
		List<TabelaNotas> lista = new ArrayList<TabelaNotas>();
		try {
			PreparedStatement ps = con.prepareStatement(query);
			ps.setString(1, disciplina.getCodigo());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				TabelaNotas nota = new TabelaNotas();
				Aluno a = new Aluno();
				a.setRa(rs.getInt("ra"));
				a.setNome(rs.getString("nome"));
				nota.setAluno(a);
				nota.setNota1(rs.getDouble("nota1"));
				nota.setNota2(rs.getDouble("nota2"));
				nota.setNota3(rs.getDouble("nota3"));
				nota.setPreexame(rs.getDouble("preexame"));
				nota.setNotaP3(rs.getDouble("notap3"));
				nota.setMedia(rs.getDouble("media"));
				nota.setSituacao(rs.getString("situacao"));
				lista.add(nota);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	@Override
	public List<TabelaFaltas> listarFaltas(Disciplinas disciplina) {
		Connection con = GenericDAO.getInstance().getConnection();
		String query = "select * from fn_recebefaltas(?)";
		List<TabelaFaltas> lista = new ArrayList<TabelaFaltas>();
		try {
			PreparedStatement ps = con.prepareStatement(query);
			
			ps.setString(1, disciplina.getCodigo());
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				TabelaFaltas falta = new TabelaFaltas();
				Aluno a = new Aluno();
				a.setRa(rs.getInt("ra"));
				a.setNome(rs.getString("nome"));
				falta.setAluno(a);
				falta.setAula1(rs.getInt("aula1"));
				falta.setAula2(rs.getInt("aula2"));
				falta.setAula3(rs.getInt("aula3"));
				falta.setAula4(rs.getInt("aula4"));
				falta.setAula5(rs.getInt("aula5"));
				falta.setAula6(rs.getInt("aula6"));
				falta.setAula7(rs.getInt("aula7"));
				falta.setAula8(rs.getInt("aula8"));
				falta.setAula9(rs.getInt("aula9"));
				falta.setAula10(rs.getInt("aula10"));
				falta.setAula11(rs.getInt("aula11"));
				falta.setAula12(rs.getInt("aula12"));
				falta.setAula13(rs.getInt("aula13"));
				falta.setAula14(rs.getInt("aula14"));
				falta.setAula15(rs.getInt("aula15"));
				falta.setAula16(rs.getInt("aula16"));
				falta.setAula17(rs.getInt("aula17"));
				falta.setAula18(rs.getInt("aula18"));
				falta.setAula19(rs.getInt("aula19"));
				falta.setAula20(rs.getInt("aula20"));
				falta.setTotalfaltas(rs.getInt("total_faltas"));
				lista.add(falta);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lista;
	}
	
	@Override
	public String adicionaNota(Aluno aluno) {
		
		Connection con = GenericDAO.getInstance().getConnection();
		String query = "{call pr_inserirnotas(?, ?, ?, ?, ?)}";
		String saida = null;
		
		try {
			CallableStatement cs = con.prepareCall(query);
			cs.setInt(1, aluno.getRa());
			cs.setString(2, aluno.getNota().getDisciplina().getCodigo());
			cs.setInt(3, aluno.getAv().getCodigo());
			cs.setDouble(4, aluno.getNota().getNota());
			cs.registerOutParameter(5, Types.VARCHAR);
			cs.execute();
			saida = (cs.getString(5));
			cs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return saida;	
	}
	
	@Override
	public String adicionaFalta(Aluno aluno) {

		Connection con = GenericDAO.getInstance().getConnection();
		String query = "{call pr_inserirfaltas(?, ?, ?, ?, ?)}";
		String saida = null;
		
		try {
			CallableStatement cs = con.prepareCall(query);
			cs.setInt(1, aluno.getRa());
			cs.setString(2, aluno.getFalta().getDisciplina().getCodigo());
			cs.setInt(3, aluno.getFalta().getPresenca());
			cs.setString(4, aluno.getFalta().getData());
			cs.registerOutParameter(5, Types.VARCHAR);
			cs.execute();
			saida = (cs.getString(5));
			cs.close();	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return saida;
	}
	
	@Override
	public String adicionaAluno(Aluno aluno) {

		Connection con = GenericDAO.getInstance().getConnection();
		String query = "{call pr_inserirAluno(?, ?)}";
		String saida = null;
		
		try {
			CallableStatement cs = con.prepareCall(query);
			cs.setString(1, aluno.getNome());
			cs.registerOutParameter(2, Types.VARCHAR);
			cs.execute();
			saida = (cs.getString(2));
			cs.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return saida;
	}
}
