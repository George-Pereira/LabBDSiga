package controller;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DaoFaltas;
import entity.Faltas;


@WebServlet("/inserefaltas")
public class ServletFaltas extends HttpServlet 
{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		inserirFaltas(req, resp);
	}

	private void inserirFaltas(HttpServletRequest req, HttpServletResponse resp) 
	{
		try {
			DaoFaltas dao = new DaoFaltas();
			Faltas aluno = new Faltas();
			aluno.setRa_aluno(req.getParameter("ra_aluno"));
			aluno.setCodigo_disciplina(req.getParameter("cod_disc"));
			String dataPagina = req.getParameter("data");
			Date date = new SimpleDateFormat("dd/MM/yyyy").parse(dataPagina);
			aluno.setDia(date);
			aluno.setPresencas(Integer.parseInt(req.getParameter("presencas")));
			dao.inserirFaltas(aluno);
		} catch (ParseException | SQLException e) {
			e.printStackTrace();
		}
		
	}
}
