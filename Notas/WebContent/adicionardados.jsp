<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import= "modelo.Aluno" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Adiciona Dados</title>
<script type="text/javascript" src="./resources/js/jquery-3.3.1.js"></script>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css"/>
<script>
$(document).ready(function(){
	$("#P3").hide();
	$("#PreExame").hide();
	$("#MonografiaCompleta").hide();
	$("#MonografiaResumida").hide();
	$('#aula3').attr('checked', false); 
	$('#aula4').attr('checked', false); 
});

$(document).ready(function(){
	$("#disciplina").click(function(){
	var selecionado = $("#disciplina").val();
		if (selecionado === "4203010" || selecionado === "4203020" || selecionado === "4208010" ||selecionado === "4226004") {
			$("#P3").hide();
			$("#PreExame").hide();
			$("#Trabalho").show();
			$("#MonografiaCompleta").hide();
			$("#MonografiaResumida").hide();
			$("#P1").show();
			$("#P2").show();
		} else if (selecionado === "4213003" || selecionado === "4213013") {
			$("#P3").hide();
			$("#PreExame").show();
			$("#Trabalho").show();
			$("#MonografiaCompleta").hide();
			$("#MonografiaResumida").hide();
			$("#P1").show();
			$("#P2").show();
		} else if (selecionado === "4233005") {
			$("#P3").show();
			$("#PreExame").hide();
			$("#Trabalho").hide();
			$("#MonografiaCompleta").hide();
			$("#MonografiaResumida").hide();
			$("#P1").show();
			$("#P2").show();
		} else if (selecionado === "5005220") {
			$("#P3").hide();
			$("#PreExame").hide();
			$("#Trabalho").hide();
			$("#MonografiaCompleta").show();
			$("#MonografiaResumida").show();
			$("#P1").hide();
			$("#P2").hide();
		}
	});
});
</script>
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
		<div> Disciplina: <select name="disciplina" id="disciplina">
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
			<option value="1" id="P1"> P1 </option>
			<option value="2" id="P2"> P2 </option>
			<option value="3" id="P3"> P3 </option>
			<option value="4" id="Trabalho"> Trabalho </option>
			<option value="5" id="MonografiaCompleta"> Monografia Completa </option>
			<option value="6" id="MonografiaResumida"> Monografia Resumida </option>
			<option value="7" id="PreExame"> Pré Exame </option>
			<option value="8" id="Exame"> Exame </option>
		</select></div>
		<div> Adicionar Nota: <input type="Text" name="nota"/></div>	
		<button type="submit" value="adicionaNota" name="cmd">Adicionar Nota</button>
	</form>	
	
	<!-- ADICIONA FALTA -->
	<hr>	
	<form action="./ControleTotal" method="post">
	<div> RA: <input type="Text" name="ra"/></div>
	<div> Disciplina: <select name="disciplina" id="dispFalta">
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
	<div> Presença: <input type="CheckBox" name="chkFalta" id="aula1"/>
				  <input type="CheckBox" name="chkFalta" id="aula2"/>
				  <input type="CheckBox" name="chkFalta" id="aula3" checked="checked"/>
				  <input type="CheckBox" name="chkFalta" id="aula4" checked="checked"/>
	</div>
	<button type="submit" value="adicionaFalta" name="cmd"> Enviar </button>
	</form>
</body>
</html>