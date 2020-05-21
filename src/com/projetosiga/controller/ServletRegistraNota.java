package com.projetosiga.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.projetosiga.dao.DaoAluno;
import com.projetosiga.dao.DaoAvaliacao;
import com.projetosiga.dao.IntDaoAluno;
import com.projetosiga.entity.Aluno;
import com.projetosiga.entity.Avaliacao;

/**
 * Servlet implementation class ServletRegistraNota
 */
@WebServlet("/registraNota")
public class ServletRegistraNota extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String cod_disc = req.getParameter("codigo_disciplina");
		if (cod_disc == null) {
			cod_disc = req.getParameter("disciplina");
		}
		IntDaoAluno dao = new DaoAluno();
		List<Aluno> alunos = new LinkedList<Aluno>();
		alunos = dao.getListaAlunos(cod_disc);
		resp.setContentType("text/html");
		StringBuffer sb = new StringBuffer();
		
		List<Avaliacao> listaAvaliacao = new LinkedList<Avaliacao>();
		DaoAvaliacao daoAvaliacao = new DaoAvaliacao();
		try {
			listaAvaliacao = daoAvaliacao.getListaAvaliacao();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		// ADICINANDO A NAV BAR
		sb.append("<header>");
	    sb.append("<div class=\"navBar\">");
	    sb.append("<ul>");
	    sb.append("<li><img src=\"./img/logosiga.png\" id=\"logo\"></li>");
	    sb.append("<li><a href=\"./index.jsp\">Home</a></li>");
	    sb.append("<li><a href=\"./selchamada.jsp\">Chamada</a></li>");
	    sb.append("<li><a href=\"./registrarNota.jsp\" class=\"active\">Registrar Nota</a></li>");
	    sb.append("<li class=\"dropdown\">");
	    sb.append("<a class=\"dropbtn\">Relatórios</a>");
	    sb.append("<div class=\"dropdown-content\">");
	    sb.append("<a href=\"./gerarMedias.jsp\">Gerar Médias</a>");
	    sb.append("<a href=\"./gerarFaltas.jsp\">Gerar Faltas</a>");
	    sb.append("</div>");
	    sb.append("</li>");
	    sb.append("</ul>");
	    sb.append("</div>");
	    sb.append("</header>");
	    // FIM DA NAV BAR
		
		sb.append("<div id=\"campos\" align=\"center\" style=\"padding:50px;\">"
				+ "<form action=\"insereNota\" method=\"post\">" + 
				"<label for=\"nota\">Disciplina</label>" + 
				"<input type=\"text\" id=\"codigo_disciplina\" name=\"codigo_disciplina\" required readonly value=\""+cod_disc+"\" <br><br>"+
				"		<label for=\"ra_aluno\">Nome do Aluno </label>" + 
				"		<select id=\"ra_aluno\" name=\"ra_aluno\" required style=\"height: 25px; width: 250px;\">");
		for (Aluno aluno : alunos) {
			sb.append("<option value=\""+aluno.getRa()+"\">"+aluno.getNome()+"</option>\""); 
		}
		sb.append("</select><br><br>" + 
				"		<label for=\"codigo_avaliacao\">Código da Avaliação </label>" + 
				"		<select id=\"codigo_avaliacao\" name=\"codigo_avaliacao\" required style=\"height: 30px; width: 80px;\">");
		for (Avaliacao avaliacao : listaAvaliacao) {
			sb.append("<option value=\""+avaliacao.getCodigo()+"\">"+avaliacao.getTipo()+"</option>\""); 
		}
		sb.append("</select><br><br>" + 
				"		<label for=\"nota\">Nota </label>" + 
				"		<input type=\"number\" autocomplete=\"off\" step=\"any\" id=\"nota\" min=\"0\" name=\"nota\" required style=\"height: 30px; width: 80px;\"><br>" + 
				"		<label for=\"peso\">Peso </label>" + 
				"		<input type=\"number\" autocomplete=\"off\" step=\"any\" id=\"peso\" min=\"0\" name=\"peso\" required style=\"height: 30px; width: 80px;\"><br>" + 
				"		<input type=\"submit\" value=\"Registrar\">" + 
				"</div></form>");
		
		sb.append("<script type=\"text/javascript\" src=\"script.js\"></script>");
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\">");
		try {
			PrintWriter out = resp.getWriter();
			out.println(sb);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
