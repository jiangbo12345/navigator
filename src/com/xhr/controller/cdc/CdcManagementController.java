package com.xhr.controller.cdc;

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

import com.xhr.entity.CdcOrganization;
import com.xhr.entity.user.Cdc;
import com.xhr.entity.user.Role;
import com.xhr.service.ICdcOrganizationService;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("admin")
public class CdcManagementController {
	@Autowired
	IUserService userService;
	
	@Autowired
	ICdcOrganizationService cdcOrgService;
	
	@RequestMapping(value = "cdcList", method = RequestMethod.GET)
    public ModelAndView List(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List list = userService.getAll(Role.CDC);
    	ModelMap map = new ModelMap();
    	map.put("list", list);
		return new ModelAndView("admin/cdcList", map);
    }
    @RequestMapping(value = "searchCDC", method = RequestMethod.POST)
    public ModelAndView searchCDC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String userName = request.getParameter("cdcName");
		String city = request.getParameter("city");
		String district = request.getParameter("district");
		if (userName.equals("")) {
			userName = null;
		}
		if (city.equals("")) {
			city =null;
		}
		if (district.equals("")) {
			district = null;
		}
    	List<Cdc> list = userService.getCDCsByParameters(userName,city,district);
    	ModelMap map = new ModelMap();
    	map.put("list", list);
		return new ModelAndView("admin/cdcList", map);
    }
	@RequestMapping(value = "updateCDC", method = RequestMethod.GET)
    public ModelAndView updatePatient(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
    	ModelMap map = new ModelMap();
    	Cdc pat =(Cdc) userService.getUserByID(Integer.parseInt(id));
    	List<CdcOrganization> cdcorgs = cdcOrgService.getAll();
		map.put("user", pat);
		map.put("cdcorgs", cdcorgs);
		return new ModelAndView("admin/update", map);
    }
    @RequestMapping(value = "addCdc", method = RequestMethod.GET)
	public ModelAndView add(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
    	ModelMap map = new ModelMap();
    	List<CdcOrganization> cdcOrgs = cdcOrgService.getAll();
		map.put("role", Role.CDC);
		map.put("cdcOrgs", cdcOrgs);
		return new ModelAndView("user/register", map);
	}
}
