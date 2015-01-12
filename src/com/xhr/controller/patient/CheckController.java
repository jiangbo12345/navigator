package com.xhr.controller.patient;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.xhr.entity.Display;
import com.xhr.entity.PatientCheck;
import com.xhr.entity.ProgramType;
import com.xhr.entity.user.Patient;
import com.xhr.service.IPatientCheckService;

@Controller
@RequestMapping("/patientcheck")
public class CheckController {
	private static final Logger LOG = Logger.getLogger(CheckController.class);
	@Autowired
	IPatientCheckService checkDervice;

	@RequestMapping(value = "add", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("patientcheck/addcheck", null);
	}
	@RequestMapping(value = "imageView", method = RequestMethod.GET)
	public ModelAndView imageView(Integer id,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		PatientCheck pat  = checkDervice.findById(id);
		ModelMap map = new ModelMap();
		map.put("patCheck", pat);
		return new ModelAndView("patientcheck/imageView", map);
	}
	
	@RequestMapping(value = "deletePatientCheck", method = RequestMethod.GET)
	public String deletePatientCheck(Integer id,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		System.out.println("id==============="+id);
		PatientCheck pat  = checkDervice.findById(id);
		pat.setDisplay(Display.Blank);
		checkDervice.update(pat);
		if (pat.getCheckType().equals(ProgramType.XRay)) {
			return "redirect:/doctor/xrayabnormal";
		}else{
			return "redirect:/doctor/sputumabnormal";
		}
	}
	
	@RequestMapping(value = "saveCheckRecord", method = RequestMethod.POST)
	public String saveCheckRecord(@RequestParam("fileImage") MultipartFile fileImage,PatientCheck check,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		LOG.info("getOriginalFilename  =="+fileImage.getOriginalFilename());
		LOG.info("getResult  =="+check.getResult());
		LOG.info("getParameter=="+request.getParameter("result"));
		HttpSession session = request.getSession();
		Patient patient = (Patient) session.getAttribute("patient");
		check.setPatient(patient);
		String pathDir = "/content/static/img/"+patient.getId()+"/"; 
	    String logoRealPathDir =request.getSession().getServletContext().getRealPath(pathDir);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss"); 
		if (check.getCheckType().equals(ProgramType.XRay)) {
			String fileName = fileImage.getOriginalFilename();
			check.setFileName(fileName);
			String suffix=  fileName.substring(fileName.lastIndexOf("."));
			String name = sdf.format(new Date())+suffix;
			 File file1 = new File(logoRealPathDir);
			 if (!file1.exists()) file1.mkdirs();
			 File file = new File(logoRealPathDir,name);
			 if(file.getParentFile()==null) file.mkdirs();
			 fileImage.transferTo(file);
			 LOG.info("lu jin "+file.getPath());
			 check.setFilePath(pathDir+name); 
		}
		check.setDisplay(Display.Show);
		checkDervice.save(check);
		return "redirect:/patient/index";
	}

}
