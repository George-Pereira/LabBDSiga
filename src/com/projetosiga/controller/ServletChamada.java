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
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		gerarChamada(req, resp);
	}

	private void gerarChamada(HttpServletRequest req, HttpServletResponse resp) 
	{
		String cod_disc = req.getParameter("disciplina");
		String dt = req.getParameter("data");
		IntDaoAluno dao = new DaoAluno();
		List<Aluno> chamada = new LinkedList<Aluno>();
		chamada = dao.getListaAlunos(cod_disc);
		resp.setContentType("text/html");
		StringBuffer sb = new StringBuffer();
		sb.append("<div align=\"center\">");
		sb.append("<table width=\"60%\">");
		sb.append("<thead>");
		sb.append("<tr align=\"center\" style=\"padding:50px\">");
		sb.append("<th>RA</th><th>Nome</th><th>Faltas</th></thead><tbody>");
		int td = 0;
		for(Aluno a : chamada)
		{
			sb.append("<tr align=\"center\" id=\"linha" + td +"\">");
			sb.append("<td>" + a.getRa() + "</td>");
			sb.append("<td>" + a.getNome() + "</td>");
			sb.append("<td><input type=\"checkbox\" id=\"presenca1linha" + td + "\" value=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">");
			sb.append("<td><input type=\"checkbox\" id=\"presenca2linha" + td + "\" value=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">");
			sb.append("<td><input type=\"checkbox\" id=\"presenca3linha" + td + "\" value=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">");
			sb.append("<td><input type=\"checkbox\" id=\"presenca40linha" + td + "\" value=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\"></td></tr>");
		}
		sb.append("</tbody>");
		sb.append("</table>");
		sb.append("</div>");
		try {
			PrintWriter out = resp.getWriter();
			out.println(sb);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
