package com.projetosiga.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.projetosiga.dao.DaoAluno;
import com.projetosiga.dao.IntDaoAluno;
import com.projetosiga.entity.Aluno;
@WebServlet("/chamada")
public class ServletChamada extends HttpServlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		gerarChamada(req, resp);
	}

	private void gerarChamada(HttpServletRequest req, HttpServletResponse resp) 
	{
		String cod_disc = req.getParameter("disciplina");
		String dt = req.getParameter("data");
		System.out.println(dt);
		IntDaoAluno dao = new DaoAluno();
		List<Aluno> chamada = new LinkedList<Aluno>();
		chamada = dao.getListaAlunos(cod_disc);
		resp.setContentType("text/html");
		StringBuffer sb = new StringBuffer();
		
		// ADICINANDO A NAV BAR
		sb.append("<header>");
	    sb.append("<div class=\"navBar\">");
	    sb.append("<ul>");
	    sb.append("<li><img src=\"./img/logosiga.png\" id=\"logo\"></li>");
	    sb.append("<li><a href=\"./index.jsp\">Home</a></li>");
	    sb.append("<li><a href=\"./selchamada.jsp\" class=\"active\">Chamada</a></li>");
	    sb.append("<li><a href=\"./registrarNota.jsp\">Registrar Nota</a></li>");
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
	    
	    // INICIO TABELA
		sb.append("<div align=\"center\" style=\"margin: 0 auto;\">");
		sb.append("<table width=\"60%\">");
		sb.append("<thead>");
		sb.append("<tr align=\"center\" style=\"padding:50px\">");
		sb.append("<th>RA</th><th>Nome</th><th>Faltas</th></thead><tbody>");
		int td = 0;
		for(Aluno a : chamada) {
			sb.append("<tr align=\"center\" id=\"linha" + td +"\" style=\"background-color: white;\">"
						+ "<td>" + a.getRa() + "</td>"
						+ "<td>" + a.getNome() + "</td>"
						+ "<td>"
							+ "<input type=\"checkbox\" id=\"presenca1linha" + td + "\" onchange=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">"
							+ "<input type=\"checkbox\" id=\"presenca2linha" + td + "\" onchange=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">"
							+ "<input type=\"checkbox\" id=\"presenca3linha" + td + "\" onchange=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">"
							+ "<input type=\"checkbox\" id=\"presenca4linha" + td + "\" onchange=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">"
						+ "</td>"
					+ "</tr>");
			td++;
		}
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		
		
		sb.append("<script type=\"text/javascript\" src=\"script.js\"></script>");
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\">");
		// FIM TABELA
		try {
			PrintWriter out = resp.getWriter();
			out.println(sb);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
