package com.projetosiga.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.projetosiga.dao.DaoNotas;
import com.projetosiga.dao.IntDaoNotas;
import com.projetosiga.entity.Notas;

@WebServlet("/insereNota")
public class ServletNotas extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Notas nota = new Notas();
		nota.setRa_aluno(request.getParameter("ra_aluno"));
		nota.setCodigo_disciplina(request.getParameter("codigo_disciplina"));
		int cod_av = Integer.valueOf(request.getParameter("codigo_avaliacao"));
		nota.setCodigo_avaliacao(cod_av);
		Double valor_nota = Double.valueOf(request.getParameter("nota"));
		nota.setNota(valor_nota);
		Double valor_peso = Double.valueOf(request.getParameter("peso"));
		nota.setPeso(valor_peso);
		
		IntDaoNotas dao = new DaoNotas();
		try {
			dao.inserirNota(nota);
			request.getSession().setAttribute("MENSAGEM", "Nota inserida com sucesso!");
		} catch (SQLException e) {
			try {
				dao.atualizaNota(nota);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			request.getSession().setAttribute("MENSAGEM", "Nota j� inserida!\nAtualizando nota...\nNota atualizada com sucesso!");
		}
		request.getSession().setAttribute("peso", valor_peso);
		request.getSession().setAttribute("cod_av", cod_av);
		response.sendRedirect("./registrarNotaS.jsp?disciplina="+nota.getCodigo_disciplina());
	}
	
	
	
}
