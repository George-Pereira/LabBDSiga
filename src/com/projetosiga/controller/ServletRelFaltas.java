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
@WebServlet("/relatoriofaltas")
public class ServletRelFaltas extends HttpServlet 
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException 
	{
		construirRelatorio(req, resp);
	}

	private void construirRelatorio(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException 
	{
		String codisc = req.getParameter("disciplina");
		String caminho = "WEB-INF/report/relatorioFaltas.jasper";
		String opc = req.getParameter("cmd");
		if(opc.equals("pdf")) 
		{
			HashMap<String, Object> content = new HashMap<String, Object>();
			content.put("codisc", codisc);
			byte [] repo = null;
			ServletContext contextServ = getServletContext();
			try 
			{
				JasperReport relatorio = (JasperReport) JRLoader.loadObjectFromFile(contextServ.getRealPath(caminho));
				repo = JasperRunManager.runReportToPdf(relatorio, content, new DaoGenerica().getConnection());
			}
			catch(JRException e) 
			{
				e.printStackTrace();
			}
			finally 
			{
				if(repo != null) 
				{
					resp.setContentType("application/pdf");
					resp.setContentLength(repo.length);
					ServletOutputStream sos = resp.getOutputStream();
					sos.write(repo);
					sos.flush();
					sos.close();
				}
				else 
				{
					RequestDispatcher dispatcher = req.getRequestDispatcher("./gerarFaltas.jsp");
					dispatcher.forward(req, resp);
				}
			}
		}
		else 
		{
			resp.sendRedirect("./gerarFaltas.jsp?disciplina=" + codisc);
		}
	}
}
