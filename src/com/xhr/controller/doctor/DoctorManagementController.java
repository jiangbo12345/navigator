package com.xhr.controller.doctor;

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

import com.xhr.entity.Hospital;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Role;
import com.xhr.service.IHospitalService;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("admin")
public class DoctorManagementController {
	@Autowired
	IUserService userService;
	
	@Autowired
	IHospitalService hospitalService;
	
	@RequestMapping(value = "doctorList", method = RequestMethod.GET)
    public ModelAndView List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List list = userService.getAll(Role.DOCTOR);
    	ModelMap map = new ModelMap();
    	map.put("list", list);
		return new ModelAndView("admin/doctorList", map);
    }
    @RequestMapping(value = "searchDoctor", method = RequestMethod.POST)
    public ModelAndView searchDocto(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String doctorName =request.getParameter("doctorName");
    	String hospitalName =request.getParameter("hospitalName");
    	String ishava = request.getParameter("ishava");
    	System.out.println("jiangbo   is hava ======"+ishava);
    	List<Doctor> list = userService.getDoctorsByParameters(doctorName,hospitalName,ishava);
    	ModelMap map = new ModelMap();
    	map.put("list", list);
		return new ModelAndView("admin/doctorList", map);
    }
	@RequestMapping(value = "updaterDoctor", method = RequestMethod.GET)
    public ModelAndView updatePatient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
    	ModelMap map = new ModelMap();
    	Doctor pat =(Doctor) userService.getUserByID(Integer.parseInt(id));
    	List<Hospital> hospitals = hospitalService.getAll();
		map.put("user", pat);
		map.put("hospitals", hospitals);
		return new ModelAndView("admin/update", map);
    }
    @RequestMapping(value = "addDoctor", method = RequestMethod.GET)
   	public ModelAndView add(HttpServletRequest request,
   			HttpServletResponse response) throws ServletException, IOException {
       	ModelMap map = new ModelMap();
    	List<Hospital> hospitals = hospitalService.getAll();
   		map.put("role", Role.DOCTOR);
		map.put("hospitals", hospitals);
   		return new ModelAndView("user/register", map);
   	}
}
