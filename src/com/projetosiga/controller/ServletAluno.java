package com.projetosiga.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.projetosiga.dao.DaoAluno;
import com.projetosiga.dao.IntDaoAluno;
import com.projetosiga.entity.Aluno;

@WebServlet("/aluno")
public class ServletAluno extends HttpServlet 
{
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		inserir(req, resp);
	}

	private void inserir(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		String ra = req.getParameter("ra");
		String nome_aluno = req.getParameter("nome");
		Aluno al = new Aluno();
		al.setNome(nome_aluno);
		al.setRa(ra);
		IntDaoAluno dao = new DaoAluno();
		try {
			dao.insereAluno(al);
			req.getSession().setAttribute("msg", "Aluno Inserido com Sucesso!");
		} catch (SQLException e) {
			req.getSession().setAttribute("msg", "Falha ao Inserir o Aluno, tente novamente mais tarde...");
			e.printStackTrace();
		}
		resp.sendRedirect("./aluno.jsp");
	}
}
