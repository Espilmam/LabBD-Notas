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
	<form action="./ Telinha de adicionar dados" method="post">
	<div> Nome do aluno: <input type="Text" name="aluno"/></div>
	<button type="submit" name="adicionaAluno">Adicionar Aluno</button>
	</form>
	
	<hr>
	
	<form action="./ Telinha de adicionar notas" method="post">
	<div> RA: <input type="Text" name="nota"/></div>
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
	<button type="submit" name="adicionaNota">Adicionar Nota</button>
	</form>
	
	<hr>
	
	<form action="./ Telinha para adicionar faltas" method="post">
	<div> RA: <input type="Text" name="nota"/></div>
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
	<div> Faltas: <input type="CheckBox" name="falta1"/>
				  <input type="CheckBox" name="falta2"/>
				  <input type="CheckBox" name="falta3"/>
				  <input type="CheckBox" name="falta4"/>
	</div>
	<button type="submit" name="adicionafalta"> Enviar </button>
	</form>
</body>
</html>