package com.xhr.controller.doctor;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import com.xhr.entity.CheckResult;
import com.xhr.entity.Display;
import com.xhr.entity.PatientCheck;
import com.xhr.entity.Plan;
import com.xhr.entity.ProgramType;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.service.IExecuteService;
import com.xhr.service.IPatientCheckService;
import com.xhr.service.IPlanService;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("/doctor")
public class DocPatientController {

	@Autowired
	IUserService userService;

	@Autowired
	IExecuteService executeService;

	@Autowired
	IPlanService planService;

	@Autowired
	IPatientCheckService checkService;

	// 患者去病人首页
	@RequestMapping(value = "patient", method = RequestMethod.GET)
	public String patient(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		Patient patient = userService.getPatientById(id);
		HttpSession session = request.getSession();
		session.setAttribute("patient", patient);
		return "redirect:/patient/index";
	}

	// 未服药病人列表
	@RequestMapping(value = "notakepatients", method = RequestMethod.GET)
	public ModelAndView noTakePatients(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Doctor doctor = (Doctor) session.getAttribute("doctor");
		List<Patient> patients = userService.getPatientsByDoctor(doctor);
		StringBuilder idBuilder = new StringBuilder();
		String page = request.getParameter("page");
		for (Patient p : patients) {
			if (idBuilder.length() > 0) {
				idBuilder.append(",");
			}
			idBuilder.append(p.getId());
		}
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String today = format.format(cal.getTime());
		String taked = executeService.getTakedPatientIdListStr(
				idBuilder.toString(), today, ProgramType.Medicine);
		List<Patient> followUped = executeService.getFollowUpPatients(doctor,
				today);
		StringBuilder builder = new StringBuilder(",");
		for (Patient followed : followUped) {
			if (followed!=null) {
				builder.append(followed.getId());
				builder.append(",");
			}
		}
		String followedIds = builder.toString();
		String temp = "";
		List<Plan> noTakePatients = new ArrayList<Plan>();
		List<Patient> patientList = new ArrayList<Patient>();
		for (Patient patient : patients) {
			temp = "," + patient.getId() + ",";
			if ((!taked.contains(temp)) && (!followedIds.contains(temp))) {
				List<Plan> list = planService.getPlansByPatient(patient);
				for (Plan plan : list) {
					if (plan.getType().equals(ProgramType.Medicine)) {
						noTakePatients.add(plan);
					}
				}
				patientList.add(patient);
			}
		}
		ModelMap map = new ModelMap();
		map.put("noTakePatients", noTakePatients);
		map.put("page", page);
		System.out.println("noTakePatients=========="+noTakePatients.size());
		map.put("patientList", patientList);
		return new ModelAndView("doctor/noTakePatientList", map);
	}

	// 胸片异常病人列表
	@RequestMapping(value = "xrayabnormal", method = RequestMethod.GET)
	public ModelAndView xrayAbnormal(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Doctor doctor = (Doctor) session.getAttribute("doctor");
		List<Patient> patients = userService.getPatientsByDoctor(doctor);
		StringBuilder idBuilder = new StringBuilder();
		String page = request.getParameter("page");
		for (Patient p : patients) {
			if (idBuilder.length() > 0) {
				idBuilder.append(",");
			}
			idBuilder.append(p.getId());
		}
		List<PatientCheck> list = new ArrayList<PatientCheck>();
		String temp = "";
		String abnormalXray = checkService.getAbnormalByPatientIDListStr(
				idBuilder.toString(), ProgramType.XRay);
		for (Patient patient : patients) {
			temp = "," + patient.getId() + ",";
			if ((abnormalXray.contains(temp))) {
				List<PatientCheck> checks = checkService.getCheckList(patient);
				for (PatientCheck patientCheck : checks) {
					if (patientCheck.getCheckType().equals(
									ProgramType.XRay)
							&& patientCheck.getDisplay().equals(Display.Show)) {
						list.add(patientCheck);
					}
				}
			}
		}
		ModelMap map = new ModelMap();
		map.put("xrayAbnormalList", list);
		map.put("page", page);
		return new ModelAndView("doctor/xrayAbnormal", map);
	}

	// 痰检异常病人列表
	@RequestMapping(value = "sputumabnormal", method = RequestMethod.GET)
	public ModelAndView sputumabnormal(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		Doctor doctor = (Doctor) session.getAttribute("doctor");
		List<Patient> patients = userService.getPatientsByDoctor(doctor);
		StringBuilder idBuilder = new StringBuilder();
		String page = request.getParameter("page");
		for (Patient p : patients) {
			if (idBuilder.length() > 0) {
				idBuilder.append(",");
			}
			idBuilder.append(p.getId());
		}
		List<PatientCheck> list = new ArrayList<PatientCheck>();
		String temp = "";
		String abnormalSputum = checkService.getAbnormalByPatientIDListStr(
				idBuilder.toString(), ProgramType.Sputum);
		for (Patient patient : patients) {
			temp = "," + patient.getId() + ",";
			if ((abnormalSputum.contains(temp))) {
				List<PatientCheck> checks = checkService.getCheckList(patient);
				for (PatientCheck patientCheck : checks) {
					if (patientCheck.getResult().equals(CheckResult.POSITIVE)
							&& patientCheck.getCheckType().equals(
									ProgramType.Sputum)
							&& patientCheck.getDisplay().equals(Display.Show)) {
						list.add(patientCheck);
					}
				}
			}
		}
		ModelMap map = new ModelMap();
		map.put("sputumAbnormalList", list);
		map.put("page", page);
		return new ModelAndView("doctor/sputumAbnormal", map);
	}

	// 未服药病人列表
	@RequestMapping(value = "nofollowpatients", method = RequestMethod.GET)
	public ModelAndView nofollowpatients(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Patient p = userService.getPatientById(1);
		List<Patient> patients = new ArrayList<Patient>();
		patients.add(p);
		String taked = executeService.getTakedPatientIdListStr("1",
				"2014-10-13", ProgramType.Medicine);
		String temp = "";
		List<Patient> noFollowPatients = new ArrayList<Patient>();
		for (Patient patient : patients) {
			temp = "," + patient.getId() + ",";
			if (!taked.contains(temp)) {
				noFollowPatients.add(patient);
			}
		}
		ModelMap map = new ModelMap();
		map.put("noFollowPatients", noFollowPatients);
		return new ModelAndView("doctor/noTakePatientList", map);
	}

	// 私信
	@RequestMapping(value = "message", method = RequestMethod.GET)
	public ModelAndView message(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO
		return new ModelAndView("doctor/message", null);
	}

	@RequestMapping(value = "bloodpress", method = RequestMethod.GET)
	public ModelAndView bloodpress(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO
		return new ModelAndView("doctor/bloodpress", null);
	}

	@RequestMapping(value = "review", method = RequestMethod.GET)
	public ModelAndView review(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		// TODO
		return new ModelAndView("doctor/review", null);
	}

}
