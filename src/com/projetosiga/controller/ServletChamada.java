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
import com.projetosiga.dao.DaoDisciplina;
import com.projetosiga.dao.IntDaoAluno;
import com.projetosiga.entity.Aluno;
import com.projetosiga.entity.Disciplina;
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
		dt = dt.substring(8,10)+"/"+dt.substring(5,7)+"/"+dt.substring(0,4);
		IntDaoAluno dao = new DaoAluno();
		List<Aluno> chamada = new LinkedList<Aluno>();
		chamada = dao.getListaAlunos(cod_disc);
		resp.setContentType("text/html");
		StringBuffer sb = new StringBuffer();
		
		Disciplina disciplina = new Disciplina();
		DaoDisciplina daoDisciplina = new DaoDisciplina();
		try {
			disciplina = daoDisciplina.getDisciplinaPorCod(cod_disc);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		
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
	    if(chamada.isEmpty()) {
			sb.append("<div  align=\"center\" style=\"margin: 100px 300px; border: 3px solid red;\"><h1>NÃO HÁ ALUNOS MATRICULADOS NESTA DISCIPLINA!</h1>"
					+ "<br><button style=\"width: 100px; height: 50px\" onclick=\"location.href='./selchamada.jsp'\">Voltar</button></div>");
		} else {
			sb.append("<div align=\"center\" class=\"tabelaChamada\">");
			sb.append("<form action=\"insereFaltas\" method=\"post\">");
			sb.append("<table width=\"60%\">");
			sb.append("<thead>");
			sb.append("<tr align=\"center\" style=\"padding:50px\">");
			sb.append("<th>RA</th><th>Nome</th><th>Faltas</th></thead><tbody>");
			int td = 1;
			for(Aluno a : chamada) {
				sb.append("<tr align=\"center\" id=\"linha" + td +"\" style=\"background-color: white;\">"
							+ "<td><input type=\"text\" id=\"raAluno"+td+"\" name=\"raAluno"+td+"\" required readonly value=\""+a.getRa()+"\"></td>"
							+ "<td>" + a.getNome() + "</td>"
							+ "<td>");
								if (disciplina.getNaulas() != 40) {
									sb.append("<input type=\"checkbox\" value=\"1\" name=\"presencaLinha" + td + "\" id=\"presencaLinha" + td + "\" onchange=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">"
											+ "<input type=\"checkbox\" value=\"1\" name=\"presencaLinha" + td + "\" id=\"presencaLinha" + td + "\" onchange=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">");
								}
						sb.append("<input type=\"checkbox\" value=\"1\" name=\"presencaLinha" + td + "\" id=\"presencaLinha" + td + "\" onchange=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">"
								+ "<input type=\"checkbox\" value=\"1\" name=\"presencaLinha" + td + "\" id=\"presencaLinha" + td + "\" onchange=\"tdGanhaFoco(" + td + ")\" onblur=\"tdPerdeFoco(" + td + ")\">"
							+ "</td>"
						+ "</tr>");
				td++;
			}
			td--;
			sb.append("</tbody>");
			sb.append("</table>");
			sb.append("<input type=\"text\" id=\"codigo_disciplina\" name=\"codigo_disciplina\" readonly style=\"display: none\" value=\""+cod_disc+"\" <br>");
			sb.append("<input type=\"text\" id=\"quantidadeAlunos\" name=\"quantidadeAlunos\" readonly style=\"display: none\" value=\""+td+"\" <br>");
			sb.append("<input type=\"text\" id=\"data\" name=\"data\" readonly value=\""+dt+"\" <br><br>");
			sb.append("<input type=\"submit\" value=\"Registrar Faltas\" style=\"color: white; font-family: Helvetica,Arial,sans-serif; background-color: red; border: none; border-radius: 20px\">");
			sb.append("</form>");
			sb.append("</div>");
		}
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
