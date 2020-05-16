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
		System.out.println("aaa");
		Notas nota = new Notas();
		nota.setRa_aluno(request.getParameter("ra_aluno"));
		nota.setCodigo_disciplina(request.getParameter("codigo_disciplina"));
		nota.setCodigo_avaliacao(Integer.parseInt(request.getParameter("codigo_avaliacao")));
		nota.setNota(Double.parseDouble(request.getAttribute("codigo_avaliacao").toString()));
		
		DaoNotas dao = new DaoNotas();
		try {
			dao.inserirNota(nota);
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}

}
