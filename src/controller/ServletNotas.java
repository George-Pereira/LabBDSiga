package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dao.DaoNotas;
import dao.IntDaoNotas;
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
		RequestDispatcher conf;
		//HttpSession sessao = request.getSession();
		PrintWriter out = response.getWriter();
		response.setContentType("text/html");
		nota.setRa_aluno(request.getParameter("ra_aluno"));
		nota.setCodigo_disciplina(request.getParameter("codigo_disciplina"));
		int cod_av = Integer.valueOf(request.getParameter("codigo_avaliacao"));
		nota.setCodigo_avaliacao(cod_av);
		Double valor_nota = Double.valueOf(request.getParameter("nota"));
		nota.setNota(valor_nota);
		Double valor_peso = Double.valueOf(request.getParameter("peso"));
		nota.setNota(valor_peso);
		insereNota(nota);
		out.println("<script type=\"text/javascript\">");
		out.println("alert('Nota inserida com sucesso!!!');");
		out.println("</script>");
		//conf = request.getRequestDispatcher("/registrarNota.jsp");
		//conf.forward(request, response);
	}
	
	private void insereNota(Notas nota) {
		IntDaoNotas dao = new DaoNotas();
		try {
			dao.inserirNota(nota);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
