<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import= "modelo.Aluno" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adiciona Dados</title>
</head>
<body>

	<%
		String msg = (String) session.getAttribute("MENSAGEM");
		if (msg != null) {
	%>
	<div class="alert alert-success" role="alert"><%=msg%></div>
	<%
		session.setAttribute("MENSAGEM", null);
		}
	%>

	<!-- ADICIONA ALUNO -->
	<form action="./ControleTotal" method="post">
	<div> Nome do aluno: <input type="Text" name="aluno"/></div>
	<button type="submit" value="adicionaAluno" name="cmd">Adicionar Aluno</button>
	</form>
	
	<!-- ADICIONA NOTA -->
	<hr>
	<form action="./ControleTotal" method="post">
		<div> RA: <input type="Text" name="ra"/></div>
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
		<div> Critério: <select name="criterio">
			<option value="1"> P1 </option>
			<option value="2"> P2 </option>
			<option value="3"> P3 </option>
			<option value="4"> Trabalho </option>
			<option value="5"> Monografia Completa </option>
			<option value="6"> Monografia Resumida </option>
			<option value="7"> Pré Exame </option>
			<option value="8"> Exame </option>
		</select></div>
		<div> Adicionar Nota: <input type="Text" name="nota"/></div>	
		<button type="submit" value="adicionaNota" name="cmd">Adicionar Nota</button>
	</form>	
	
	<!-- ADICIONA FALTA -->
	<hr>	
	<form action="./ControleTotal" method="post">
	<div> RA: <input type="Text" name="ra"/></div>
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
	<div> Adicionar Data: <input type="date" name="data"/></div>
	<div> Presença: <input type="CheckBox" name="chkFalta"/>
				  <input type="CheckBox" name="chkFalta"/>
				  <input type="CheckBox" name="chkFalta"/>
				  <input type="CheckBox" name="chkFalta"/>
	</div>
	<button type="submit" value="adicionaFalta" name="cmd"> Enviar </button>
	</form>
</body>
</html>