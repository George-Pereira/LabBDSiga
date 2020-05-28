package com.projetosiga.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.projetosiga.dao.DaoDisciplina;
import com.projetosiga.dao.DaoFaltas;
import com.projetosiga.entity.Disciplina;
import com.projetosiga.entity.Faltas;


@WebServlet("/insereFaltas")
public class ServletFaltas extends HttpServlet 
{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{	
		doPost(req, resp);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		inserirFaltas(req, resp);
	}
	private void inserirFaltas(HttpServletRequest req, HttpServletResponse resp) 
	{
		try {
			DaoFaltas dao = new DaoFaltas();
			int quantidadeAlunos = Integer.parseInt(req.getParameter("quantidadeAlunos"));
			
			String dataPagina = req.getParameter("data");
			Date date = new SimpleDateFormat("dd/MM/yyyy").parse(dataPagina);
			java.sql.Date sqlDate = new java.sql.Date(date.getTime());
			
			String codigo_disciplina = req.getParameter("codigo_disciplina");
			Disciplina disciplina = new Disciplina();
			DaoDisciplina daoDisciplina = new DaoDisciplina();
			disciplina = daoDisciplina.getDisciplinaPorCod(codigo_disciplina);
			
			for(int i = 1; i <= quantidadeAlunos; i++) {
				Faltas falta = new Faltas();
				falta.setRa_aluno(req.getParameter("raAluno"+i));
				falta.setCodigo_disciplina(codigo_disciplina);
				falta.setDia(sqlDate);
				
				String[] presencas = req.getParameterValues("presencaLinha"+i);
				if (presencas != null) {
					if (disciplina.getNaulas() > 40) {
						falta.setPresencas(4 - presencas.length);
					} else {
						falta.setPresencas(2 - presencas.length);
					}
				} else {
					if (disciplina.getNaulas() > 40) {
						falta.setPresencas(4);
					} else {
						falta.setPresencas(2);
					}
				}
				dao.inserirFaltas(falta);
			}
			
			PrintWriter out = resp.getWriter();
			resp.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Chamada Realizada com Sucesso!');");
			out.println("var url= \"./selchamada.jsp\"; window.location = url;"); 
			out.println("</script>");
		}
		catch (IOException | ParseException | SQLException e) 
		{
			e.printStackTrace();
		} 
	}
}
