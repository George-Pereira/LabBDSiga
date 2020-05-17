package controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.DaoNotas;
import entity.Notas;

/**
 * Servlet implementation class ServletNotas
 */
@WebServlet("/insereNota")
public class ServletNotas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Notas nota = new Notas();
		DaoNotas dao = new DaoNotas();
		nota.setRa_aluno(request.getParameter("ra_aluno"));
		nota.setCodigo_disciplina(request.getParameter("codigo_disciplina"));
		System.out.println(request.getParameter("codigo_avaliacao"));
		nota.setCodigo_avaliacao(1);
		nota.setNota(7.2);
		
		try {
			dao.inserirNota(nota);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
