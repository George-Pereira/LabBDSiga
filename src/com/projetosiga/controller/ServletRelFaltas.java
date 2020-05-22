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

import com.projetosiga.dao.DaoFaltas;
import com.projetosiga.entity.Faltas;
@WebServlet("/relatoriofaltas")
public class ServletRelFaltas extends HttpServlet 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		construirRelatorio(req, resp);
	}

	private void construirRelatorio(HttpServletRequest req, HttpServletResponse resp) 
	{
		String cod_disc = req.getParameter("disciplina");
		DaoFaltas dao = new DaoFaltas();
		List<Faltas> chamadaClasse = new LinkedList<Faltas>();
		chamadaClasse = dao.construirRelatorio();
		resp.setContentType("text/html");
		StringBuffer sb = new StringBuffer();
		try 
		{
			PrintWriter out = resp.getWriter();
			sb.append("<header>");
		    sb.append("<div class=\"navBar\">");
		    sb.append("<ul>");
		    sb.append("<li><img src=\"./img/logosiga.png\" id=\"logo\"></li>");
		    sb.append("<li><a href=\"./index.jsp\">Home</a></li>");
		    sb.append("<li><a href=\"./selchamada.jsp\">Chamada</a></li>");
		    sb.append("<li><a href=\"./registrarNota.jsp\">Registrar Nota</a></li>");
		    sb.append("<li class=\"dropdown\">");
		    sb.append("<a class=\"dropbtn active\" >Relatórios</a>");
		    sb.append("<div class=\"dropdown-content\">");
		    sb.append("<a href=\"./gerarMedias.jsp\">Gerar Médias</a>");
		    sb.append("<a href=\"./gerarFaltas.jsp\" class=\"active\">Gerar Faltas</a>");
		    sb.append("</div>");
		    sb.append("</li>");
		    sb.append("</ul>");
		    sb.append("</div>");
		    sb.append("</header>");
		    sb.append("<script type=\"text/javascript\" src=\"script.js\"></script>");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"./style.css\">");
		    out.println(sb);
		}
		catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
}