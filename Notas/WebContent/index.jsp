<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import= "modelo.Aluno, modelo.TabelaNotas,modelo.TabelaFaltas,java.util.List" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<form action="./ControleTotal" method="post">
		<div> Disciplina: <select name="disciplina">
			<option value="4203010"> Arquitetura e Organização de Computadores - Tarde </option>
			<option value="4203020"> Arquitetura e Organização de Computadores - Noite </option>
			<option value="4208010"> Laboratório de Hardware </option>
			<option value="4213003"> Sistemas Operacionais I - Tarde </option>
			<option value="4213013"> Sistemas Operacionais I - Noite </option>
			<option value="4226004"> Banco de Dados </option>
			<option value="4233005"> Laboratório de Banco de Dados </option>
			<option value="5005220"> Métodos Para a Produção do Conhecimento </option>
		</select></div>	
		<button type="submit" value="verNotas" name="cmd">Ver Notas</button>
		<button type="submit" value="verFaltas" name="cmd">Ver Faltas</button>
	</form>
	
	<%
		String disciplina = (String)session.getAttribute("SELECIONADO"); 
		List<TabelaNotas> listaNotas = (List<TabelaNotas>)session.getAttribute("LISTANOTAS");
		List<TabelaFaltas> listaFaltas = (List<TabelaFaltas>)session.getAttribute("LISTAFALTAS");
	%>
	
	<% if (listaNotas != null && listaNotas.size() > 0) {  %>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">RA</th>
					<th scope="col">Nome</th>
					<% if (!disciplina.equals("5005220") ) { %>
					<th scope="col">P1</th>
					<th scope="col">P2</th>
					<th scope="col">T</th>
					<% } else { %>
					<th scope="col">Monografia Resumida</th>
					<th scope="col">Monografia Completa</th>
					<% } %>
					<% if (disciplina.equals("4213003") || disciplina.equals("4213013")) {%>
					<th scope="col">Pré-Exame</th>
					<% } %>
					<th scope="col">Exame</th>
					<th scope="col">Média</th>
					<th scope="col">Situação</th>
				</tr>
			</thead>
			<tbody>
				<% for(TabelaNotas lista : listaNotas) { %>
					<tr>
						<th scope="row"><%=lista.getAluno().getRa() %></th>
						<td><%=lista.getAluno().getNome() %></td>
						<td><%=lista.getNota1() %></td>
						<td><%=lista.getNota2() %></td>
						<% if (!disciplina.equals("5005220")) { %>
						<td><%=lista.getNota3() %></td>
						<% } %>
						<% if (disciplina.equals("4213003") || disciplina.equals("4213013")) {%>
						<td><%=lista.getPreexame() %></td>
						<% } %>
						<td><%=lista.getNotaP3() %></td>
						<td><%=lista.getMedia() %></td>
						<td><%=lista.getSituacao() %></td>
					</tr>
				<% } %>
			</tbody>
		</table>
	<% } 
	session.setAttribute("LISTANOTAS", null); %>
	
	<% if (listaFaltas != null && listaFaltas.size() > 0) {  %>
		<table class="table">
			<thead class="thead-dark">
				<tr>
					<th scope="col">RA</th>
					<th scope="col">Nome</th>
					<th scope="col">Aula1</th>
					<th scope="col">Aula2</th>
					<th scope="col">Aula3</th>
					<th scope="col">Aula4</th>
					<th scope="col">Aula5</th>
					<th scope="col">Aula6</th>
					<th scope="col">Aula7</th>
					<th scope="col">Aula8</th>
					<th scope="col">Aula9</th>
					<th scope="col">Aula10</th>
					<th scope="col">Aula12</th>
					<th scope="col">Aula13</th>
					<th scope="col">Aula14</th>
					<th scope="col">Aula15</th>
					<th scope="col">Aula16</th>
					<th scope="col">Aula17</th>
					<th scope="col">Aula18</th>
					<th scope="col">Aula19</th>
					<th scope="col">Aula20</th>
				</tr>
			</thead>
		<tbody>
		<% for (TabelaFaltas lista : listaFaltas) { %>
			<tr>
				<th scope="row"><%= lista.getAluno().getRa() %></th>
				<td><%=lista.getAluno().getNome() %></td>
				<td><%=lista.getAula1() %></td>
				<td><%=lista.getAula2() %></td>
				<td><%=lista.getAula3() %></td>
				<td><%=lista.getAula4() %></td>
				<td><%=lista.getAula5() %></td>
				<td><%=lista.getAula6() %></td>
				<td><%=lista.getAula7() %></td>
				<td><%=lista.getAula8() %></td>
				<td><%=lista.getAula9() %></td>
				<td><%=lista.getAula10() %></td>
				<td><%=lista.getAula11() %></td>
				<td><%=lista.getAula12() %></td>
				<td><%=lista.getAula13() %></td>
				<td><%=lista.getAula14() %></td>
				<td><%=lista.getAula15() %></td>
				<td><%=lista.getAula16() %></td>
				<td><%=lista.getAula17() %></td>
				<td><%=lista.getAula18() %></td>
				<td><%=lista.getAula19() %></td>
				<td><%=lista.getAula20() %></td>	
			</tr>
		<% } %>
		</tbody>
	</table>
	<% } 	
	session.setAttribute("LISTAFALTAS", null); %>
	
</body>
</html>