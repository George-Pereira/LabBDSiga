package com.projetosiga.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.projetosiga.dao.DaoMatricula;

@WebServlet("/matricula")
public class ServletMatricula extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cod_disc = request.getParameter("codigo_disciplina");
		String ra = request.getParameter("codigo_aluno");
		DaoMatricula daoMatricula = new DaoMatricula();
		try {
			daoMatricula.insereMatricula(cod_disc, ra);
			request.getSession().setAttribute("msg", "Matricula realizada com sucesso!");
		} catch (SQLException e) {
			e.printStackTrace();
			request.getSession().setAttribute("msg", "Matricula já existente!");
		}
		response.sendRedirect("./matricula.jsp");
	}

}
