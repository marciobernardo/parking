package com.oliveiradouglas.parking.servlets;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oliveiradouglas.parking.dao.SettingDAO;
import com.oliveiradouglas.parking.models.Setting;
import com.oliveiradouglas.parking.src.Alert;
import com.oliveiradouglas.parking.src.Breadcrumb;
import com.oliveiradouglas.parking.src.NumberConverter;

@WebServlet(urlPatterns="/settings")
public class SettingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<Breadcrumb> breadcrumbs = new ArrayList<>();
		breadcrumbs.add(new Breadcrumb("#", "settings", true));
		req.setAttribute("breadcrumbList", breadcrumbs);
		req.setAttribute("activeMenu", "settings");
		
		SettingDAO settingDAO = new SettingDAO();
		try {
			req.setAttribute("setting", settingDAO.findSetting());
		} catch (SQLException e) {
			req.setAttribute("alert", new Alert("Erro ao carregar as configurações atuais", Alert.ERROR));
		}
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/views/setting/index.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		String parkingName     = req.getParameter("parking_name");
		Double firstHourValue  = null;
		Double otherHoursValue = null;
		
		HttpSession session = req.getSession();
		
		try {
			firstHourValue = NumberConverter.convertStringToDouble(req.getParameter("first_hour_value"));
			otherHoursValue = NumberConverter.convertStringToDouble(req.getParameter("other_hours_value"));
		} catch (ParseException e) {
			session.setAttribute("alert", new Alert("Erro ao converter os valores!", Alert.ERROR));
			resp.sendRedirect("settings");
		}
		
		Setting setting = new Setting();
		setting.setParkingName(parkingName);
		setting.setFirstHourValue(firstHourValue);
		setting.setOtherHoursValue(otherHoursValue);
		
		try {
			SettingDAO dao = new SettingDAO();
			dao.insert(setting);
		} catch (SQLException e) {
			session.setAttribute("alert", new Alert("Erro ao salvar as configurações!", Alert.ERROR));
			resp.sendRedirect("settings");
		}

		session.setAttribute("alert", new Alert("Configurações salvas com sucesso!", Alert.SUCCESS));
		resp.sendRedirect("settings");
	}
}
