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

import com.projetosiga.dao.DaoFaltas;
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
			
			for(int i = 1; i <= quantidadeAlunos; i++) {
				Faltas falta = new Faltas();
				falta.setRa_aluno(req.getParameter("raAluno"+i));
				falta.setCodigo_disciplina(req.getParameter("codigo_disciplina"));
				falta.setDia(sqlDate);
				
				String[] presencas = req.getParameterValues("presencaLinha"+i);
				if (presencas != null) {
					falta.setPresencas(4 - presencas.length);
				} else {
					falta.setPresencas(4);
				}
				dao.inserirFaltas(falta);
			}
			
			PrintWriter out = resp.getWriter();
			resp.setContentType("text/html");
			out.println("<script type=\"text/javascript\">");
			out.println("alert('Nota inserida com sucesso!');");
			out.println("var url= \"./selchamada.jsp\"; window.location = url;"); 
			out.println("</script>");
		}
		catch (IOException | ParseException | SQLException e) 
		{
			e.printStackTrace();
		} 
	}
}
