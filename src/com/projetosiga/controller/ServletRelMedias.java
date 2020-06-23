package com.projetosiga.controller;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.projetosiga.dao.DaoGenerica;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.util.JRLoader;

@WebServlet("/relatorioMedias")
public class ServletRelMedias extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cod_disc = request.getParameter("codigo_disciplina");
		String jasper = "WEB-INF/report/RelMedias.jasper";
		String cmd = request.getParameter("cmd");
		if (cmd.equals("relatorioPDF")) {
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("CODIGO_DISCIPLINA", cod_disc);
			byte[] bytes = null;
			ServletContext context = getServletContext();
			try {
				JasperReport relatorio = (JasperReport) JRLoader.loadObjectFromFile(context.getRealPath(jasper));
				bytes = JasperRunManager.runReportToPdf(relatorio, param, new DaoGenerica().getConnection());
			} catch (JRException e) {
				e.printStackTrace();
			} finally {
				if (bytes != null) {
					response.setContentType("application/pdf");
					response.setContentLength(bytes.length);
					ServletOutputStream sos = response.getOutputStream();
					sos.write(bytes);
					sos.flush();
					sos.close();
				} else {
					RequestDispatcher rd = request.getRequestDispatcher("./gerarMedias.jsp");
					rd.forward(request, response);
				}
			} 
		} else {
			response.sendRedirect("./gerarMedias.jsp?disciplina="+cod_disc);
		}
	}

}
