package controle;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import modelo.Aluno;
import modelo.Avaliacao;
import modelo.Disciplinas;
import modelo.Falta;
import modelo.Nota;
import modelo.TabelaFaltas;
import modelo.TabelaNotas;

/**
 * Servlet implementation class ControleFaltas
 */
@WebServlet("/ControleTotal")
public class ControleTotal extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ControleTotal() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String cmd = request.getParameter("cmd");
		System.out.println(cmd);
		
		ControleDisciplinas cd = new ControleDisciplinas();

		if ("verNotas".equals(cmd)) {
			Disciplinas d = new Disciplinas();
			d.setCodigo(request.getParameter("disciplina"));
			List<TabelaNotas> notas;
			notas = cd.listarNotas(d);
			
			System.out.println(d.getCodigo());
			
			response.sendRedirect("./index.jsp");
			request.getSession().setAttribute("SELECIONADO", d.getCodigo());
			request.getSession().setAttribute("LISTANOTAS", notas);
		}
		
		else if ("verFaltas".equals(cmd)) {
			Disciplinas d = new Disciplinas();
			d.setCodigo(request.getParameter("disciplina"));
			List<TabelaFaltas> lista = null;
			lista = cd.listarFaltas(d);
			
			
			
			response.sendRedirect("./index.jsp");
			request.getSession().setAttribute("SELECIONADO", d.getCodigo());
			request.getSession().setAttribute("LISTAFALTAS", lista);
		}
		
		else if ("adicionaNota".equals(cmd)) {
			Aluno aluno = new Aluno();
			Disciplinas dp = new Disciplinas();
			Avaliacao av = new Avaliacao();
			Nota nota = new Nota();
			
			aluno.setRa(Integer.parseInt(request.getParameter("ra")));
			dp.setCodigo(request.getParameter("disciplina"));
			av.setCodigo(Integer.parseInt(request.getParameter("criterio")));
			nota.setNota(Double.parseDouble(request.getParameter("nota")));
			
			nota.setDisciplina(dp);
			aluno.setNota(nota);
			aluno.setAv(av);
			
			String mensagem = cd.adicionaNota(aluno);
			response.sendRedirect("./adicionardados.jsp");
			request.getSession().setAttribute("MENSAGEM", mensagem);
			
		}
		
		else if ("adicionaFalta".equals(cmd)) {
			Aluno aluno = new Aluno();
			Disciplinas dp = new Disciplinas();
			Falta falta = new Falta();
			
			aluno.setRa(Integer.parseInt(request.getParameter("ra")));
			dp.setCodigo(request.getParameter("disciplina"));
			System.out.println(dp.getCodigo() + "dddd");
			falta.setData(request.getParameter("data"));
			
			String[] chkPresenca = request.getParameterValues("chkFalta");
			
			int presenca = 0;
			
			if (chkPresenca != null) {
				for (int i = 0; i < chkPresenca.length; i++) {
					
					if ("on".equals(chkPresenca[i])) {
						
						presenca ++;
					}
				}
			}
			falta.setPresenca(presenca);
			
			falta.setDisciplina(dp);
		    aluno.setFalta(falta);
			
			String mensagem = cd.adicionaFalta(aluno);
			response.sendRedirect("./adicionardados.jsp");
			request.getSession().setAttribute("MENSAGEM", mensagem);
		}
		
		else if ("adicionaAluno".equals(cmd)) {
			Aluno aluno = new Aluno();
			
			aluno.setNome(request.getParameter("aluno"));
			
			String mensagem = cd.adicionaAluno(aluno);
			response.sendRedirect("./adicionardados.jsp");
			request.getSession().setAttribute("MENSAGEM", mensagem);
		}
	}

}
