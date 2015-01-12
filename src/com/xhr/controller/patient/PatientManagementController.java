
package com.xhr.controller.patient;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.xhr.entity.user.Patient;
import com.xhr.entity.user.Role;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("admin")
public class PatientManagementController {
	@Autowired
	IUserService userService;
    @RequestMapping(value = "patientList", method = RequestMethod.GET)
    public ModelAndView patientList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List list = userService.getAll(Role.PATIENT);
    	ModelMap map = new ModelMap();
    	map.put("list", list);
    	return new ModelAndView("admin/patientList", map);
    }
    
    @RequestMapping(value = "searchPatient", method = RequestMethod.POST)
    public ModelAndView searchPatient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String patientName = request.getParameter("userName");
    	String doctorName = request.getParameter("doctorName");
    	String ishava = request.getParameter("ishava");
    	List<Patient> list = userService.getPatientsByParameters(patientName,doctorName,ishava);
    	ModelMap map = new ModelMap();
    	map.put("list", list);
    	return new ModelAndView("admin/patientList", map);
    }
    @RequestMapping(value = "updatePatient", method = RequestMethod.GET)
    public ModelAndView updatePatient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String id = request.getParameter("id");
    	ModelMap map = new ModelMap();
    	Patient pat =(Patient) userService.getUserByID(Integer.parseInt(id));
		map.put("user", pat);
		return new ModelAndView("admin/update", map);
    }
    @RequestMapping(value = "addPatient", method = RequestMethod.GET)
	public ModelAndView add(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
    	ModelMap map = new ModelMap();
		map.put("role", Role.PATIENT);
		return new ModelAndView("user/register", map);
	}
}
