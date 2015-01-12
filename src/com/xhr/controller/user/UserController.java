
package com.xhr.controller.user;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.xhr.entity.BaseGeographic;
import com.xhr.entity.CdcOrganization;
import com.xhr.entity.Hospital;
import com.xhr.entity.Nation;
import com.xhr.entity.user.Address;
import com.xhr.entity.user.Admin;
import com.xhr.entity.user.Cdc;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.Role;
import com.xhr.entity.user.User;
import com.xhr.service.IBaseGeographicService;
import com.xhr.service.ICdcOrganizationService;
import com.xhr.service.IHospitalService;
import com.xhr.service.INationService;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    IUserService userService;
    
    @Autowired
	IBaseGeographicService baseGeographicService;
    
    @Autowired
    INationService nationService;
    
    @Autowired
    IHospitalService hospitalService;
    
    @Autowired
    ICdcOrganizationService cdcOrgService;
    
    @RequestMapping(value = "login", method = RequestMethod.POST)
    public String login(RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String pwd = request.getParameter("password");
        User user = userService.getUser(name);
        if (user == null) {
            request.getSession().setAttribute("message", "nouser");
            return "redirect:/";
        } else {
            request.getSession().removeAttribute("message");
            if (user.getPassword().equals(pwd.trim())) {
                if (user.getRole() == Role.ADMIN) {
                    Admin admin = (Admin) user;
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    session.setAttribute("loginUser", admin);
                    return "redirect:/admin/index";
                } else if (user.getRole() == Role.PATIENT) {
                    Patient patient = (Patient) user;
                    HttpSession session = request.getSession();
                    session.setAttribute("patient", patient);
                    session.setAttribute("loginUser", patient);
                    return "redirect:/patient/index";
                } else if (user.getRole() == Role.DOCTOR) {
                    Doctor doctor = (Doctor) user;
                    HttpSession session = request.getSession();
                    session.setAttribute("doctor", doctor);
                    session.setAttribute("loginUser", doctor);
                    return "redirect:/doctor/index";
                } else if (user.getRole() == Role.CDC) {
                    Cdc cdc = (Cdc)user;
                    HttpSession session = request.getSession();
                    session.setAttribute("cdc", cdc);
                    session.setAttribute("loginUser", cdc);
                    return "redirect:/cdc/index";
                } else {
                    return "redirect:/";
                }
            } else {
                System.out.println("密码错误！！");
                request.getSession().setAttribute("message", "nouser");
                return "redirect:/";
            }

        }
    }

    
      
    @RequestMapping(value = "regist", method = RequestMethod.GET)
    public ModelAndView register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	List<BaseGeographic> baseGeogList =baseGeographicService.getBasicsGeographicNodes();
    	List<Nation> nationList =  nationService.getAll();
    	List<Hospital> hospitals = hospitalService.getAll();
    	List<CdcOrganization> cdcOrgs = cdcOrgService.getAll();
    	ModelMap map = new ModelMap();
    	map.put("nationList", nationList);
    	map.put("list", baseGeogList);
    	map.put("hospitals", hospitals);
    	map.put("cdcOrgs", cdcOrgs);
    	return new ModelAndView("user/register", map);
    }

    @RequestMapping(value = "regist", method = RequestMethod.POST)
    public String registing(Address address,HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = request.getParameter("name");
        String pwd = request.getParameter("password2");
        String provience = baseGeographicService.getBaseGeographicByID(
				request.getParameter("provienceText")).getGeogDesignation();
		String city = baseGeographicService.getBaseGeographicByID(
				request.getParameter("cityText")).getGeogDesignation();
		String district = baseGeographicService.getBaseGeographicByID(
				request.getParameter("districtText")).getGeogDesignation();
		String street = baseGeographicService.getBaseGeographicByID(
				request.getParameter("streetText")).getGeogDesignation();
		address.setProvience(provience);
		address.setCity(city);
		address.setDistrict(district);
        address.setStreet(street);
        Role role = Role.valueOf(request.getParameter("role"));
        System.out.println("role  =======   " + role);
        boolean isok = false;
        if (role == Role.ADMIN) {
            Admin admin = new Admin();
            admin.setLoginName(name);
            admin.setPassword(pwd);
            admin.setRole(Role.ADMIN);
            isok = userService.regist(admin);
        } else if (Role.PATIENT == role) {
            Patient patient = new Patient();
            patient.setPhone(request.getParameter("phone"));
            patient.setUserName(request.getParameter("patientName"));
            patient.setBirthDay(request.getParameter("birthDay"));
            patient.setIdentifier(request.getParameter("identifier"));
            patient.setSex(request.getParameter("sex"));
            patient.setRegistrationDate(request.getParameter("registrationDate"));
            patient.setFirstTakeDate(request.getParameter("firstTakeDate"));
            patient.setLoginName(name);
            patient.setPassword(pwd);
            patient.setNation(request.getParameter("nation"));
            patient.setTreatNo(request.getParameter("treatNo"));
            patient.setRole(Role.PATIENT);
            patient.setAddress(address);
            isok = userService.regist(patient);
        } else if (role == Role.DOCTOR) {
            Doctor doctor = new Doctor();
            doctor.setUserName(request.getParameter("doctorName"));
            Hospital hospital = null;
            if (request.getParameter("hospitalName") !=null || !request.getParameter("hospitalName").equals("")) {
            	hospital = hospitalService.findById(Integer.parseInt(request.getParameter("hospitalName")));
			}
            doctor.setHospital(hospital);
            doctor.setDepartments(request.getParameter("departments"));
            doctor.setPhone(request.getParameter("Dphone"));
            doctor.setSex(request.getParameter("Dsex"));
            doctor.setLoginName(name);
            doctor.setPassword(pwd);
            doctor.setRole(Role.DOCTOR);
            doctor.setAddress(address);
            isok = userService.regist(doctor);
        } else if (role == Role.CDC) {
            Cdc cdc = new Cdc();
            cdc.setUserName(request.getParameter("cdcName"));
            cdc.setPhone(request.getParameter("cdcphone"));
            cdc.setSex(request.getParameter("Csex"));
            CdcOrganization cdcOrg =null;
            if (request.getParameter("cdcOrg") !=null || !request.getParameter("cdcOrg").equals("")) {
            	cdcOrg =cdcOrgService.findById(Integer.parseInt(request.getParameter("cdcOrg")));
			}
            cdc.setCdcOrg(cdcOrg);
            cdc.setLoginName(name);
            cdc.setPassword(pwd);
            cdc.setRole(Role.CDC);
            cdc.setAddress(address);
            isok = userService.regist(cdc);
        }
        if (isok) {
            return "redirect:/";
        } else {
            return "redirect:regist";
        }

    }

    @RequestMapping(value = "logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getSession().removeAttribute("loginUser");
        return "redirect:/";
    }
}
