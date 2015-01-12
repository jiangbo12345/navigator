package com.xhr.controller.doctor;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

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
import org.springframework.web.servlet.ModelAndView;

import com.xhr.entity.*;
import com.xhr.entity.user.*;
import com.xhr.model.PatientInfo;
import com.xhr.model.Suggestion;
import com.xhr.service.*;

@Controller
@RequestMapping("/doctor")
public class DoctorIndexController {

	private static final Logger LOG = Logger.getLogger(DoctorIndexController.class);

	@Autowired
	IUserService userService;

	@Autowired
	IPillBoxService pillBoxService;

	@Autowired
	IMessageService messageService;

	@Autowired
	IPlanService planService;

	@Autowired
	IExecuteService executeService;

	@Autowired
	IFollowUpSuggestionService suggestionService;

	@Autowired
	IPatientCheckService checkService;
	
	@Autowired
	INoticeService noticeService;
	
	@Autowired
	IArticleService articleService;
	
	@RequestMapping(value = "index", method = RequestMethod.GET)
	public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ModelMap map = new ModelMap();
		Doctor doctor = (Doctor) session.getAttribute("doctor");
		List<Message> messages = messageService.getToDoList(doctor);
		map.put("toDoMessages", messages);

		List<Suggestion> suggestions = suggestionService.getSuggestions(doctor);
		map.put("suggestions", suggestions);

		notExcetuedPlan(map, doctor);
		
		List<Patient> patients = userService.getPatientsByDoctor(doctor);
		
		List<Notice> list = noticeService.getNoticeByDoc((User)doctor);
		List<Article> articles = new ArrayList<Article>();
		for (Notice notice : list) {
			List<Article> arts = articleService.getNoticeId(notice.getNoticeId());
			for (Article article : arts) {
				articles.add(article);
			}
		}
		System.out.println("list.size()============"+list.size());
		map.put("notices", list);
		map.put("articles", articles);
		noMedicineRecordPatients(map, doctor, patients);
		return new ModelAndView("doctor/index", map);
	}

	@RequestMapping(value = "addToDoMessage", method = RequestMethod.POST)
	public String addToDoMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String content = request.getParameter("todoMessage");
		HttpSession session = request.getSession();
		Doctor doctor = (Doctor) session.getAttribute("doctor");
		User loginUser = (User) session.getAttribute("loginUser");
		Message message = new Message();
		message.setContent(content);
		message.setFrom(loginUser);
		message.setSendTo(doctor);
		message.setIsRead(false);
		message.setShowInIndex(true);
		message.setType(MessageType.TODO);
		messageService.save(message);
		return "redirect:index";
	}

	@RequestMapping(value = "deleteToDoMessage", method = RequestMethod.GET)
	public String deleteToDoMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer messageId = Integer.parseInt(request.getParameter("id"));
		messageService.delete(messageId);
		return "redirect:index";
	}

	@RequestMapping(value = "addFollowUp", method = RequestMethod.GET)
	public String addFollowUp(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer patientId = Integer.parseInt(request.getParameter("patientId"));
		Patient patient = userService.getPatientById(patientId);
		HttpSession session = request.getSession();
		Doctor doctor = (Doctor) session.getAttribute("doctor");

		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String visitDate = format.format(cal.getTime());
		SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
		String visitTime = timeFormat.format(cal.getTime());

		ExecuteRecord record = new ExecuteRecord();
		record.setExecuteDate(visitDate);
		record.setExecuteTime(visitTime);
		record.setExecutor(doctor);
		record.setAimUser(patient);
		record.setType(ProgramType.Followup);
		executeService.save(record);
		return "redirect:index";
	}

	// 添加医患监督
	@RequestMapping(value = "relation", method = RequestMethod.POST)
	public String relation(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String patientName = request.getParameter("patientName");
		String identifier = request.getParameter("identifier");
		String pillBoxID = request.getParameter("pillBoxID");
		String language = request.getParameter("language");
		String registrationDate = request.getParameter("registrationDate");
		String firstTakeDate = request.getParameter("firstTakeDate");
		return addreiation("redirect:index", request, identifier, patientName, pillBoxID, language, registrationDate, firstTakeDate);

	}

	private String addreiation(String ret, HttpServletRequest request, String identifier, String patientName, String pillBoxID, String language,
			String registrationDate, String firstTakeDate) throws ParseException {

		Patient patient = userService.getPatientByIdentifier(identifier);
		if (patient != null) {
			if (patient.getUserName().equals(patientName.trim())) {
				if (!registrationDate.trim().equals("")) {
					patient.setRegistrationDate(registrationDate);
				}
				if (!firstTakeDate.trim().equals("")) {
					LOG.info("firstTakeDate=====" + firstTakeDate);
					patient.setFirstTakeDate(firstTakeDate);
				}
				patient.setLanguage(PropagandaLanguage.valueOf(language));
				Doctor doctor = (Doctor) request.getSession().getAttribute("doctor");
				List<Doctor> list = null;
				if (patient.getDoctors() != null && patient.getDoctors().size() > 0) {
					list = patient.getDoctors();
					for (Doctor doc : list) {
						if (doc.getId() == doctor.getId()) {
							return reiationPillBox(ret, pillBoxID, patient);
						}
					}
					list.add(doctor);
				} else {
					list = new ArrayList<Doctor>();
					list.add(doctor);
				}
				patient.setDoctors(list);
				boolean isok = userService.update(patient);
				addDefaultFollowUpPlan(doctor, patient);
				addDefaultMedicinePlan(doctor, patient);
				addDefaultXrayPlan(doctor, patient);
				addDefaultSputumPlan(doctor, patient);
				addRemindXrayPlan(doctor, patient);
				addRemindSputumPlan(doctor, patient);
				if (isok) {
					return reiationPillBox(ret, pillBoxID, patient);
				}
			} else {
				LOG.info("patientName not have！！ treatNo bu zheng que");
			}
		} else {
			LOG.info("no people");
		}
		return ret;
	}

	private String reiationPillBox(String ret, String pillBoxID, Patient patient) {
		System.out.println("添加关系成功！！");
		PillBox pillBox = pillBoxService.findById(pillBoxID);
		boolean isok = false;
		if (pillBox != null) {
			PillBox pillBoxOld = patient.getPillBox();
			patient.setPillBox(pillBox);
			isok = userService.update(patient);
			if (isok) {
				System.out.println("添加药盒成功！！");
				pillBox.setState(State.ENABLE);
				pillBoxService.update(pillBox);
				if (pillBoxOld != null) {
					pillBoxOld.setState(State.UNABLE);
					pillBoxService.update(pillBoxOld);
				}
			}
		} else {
			System.out.println("没有该药盒！！");
		}
		return ret;
	}

	private void addDefaultMedicinePlan(Doctor doctor, Patient patient) {
		Plan plan = new Plan();
		plan.setTitle("按时服药");
		plan.setType(ProgramType.Medicine);
		plan.setFromUser(doctor);
		plan.setToUser(patient);
		plan.addPeriod(Period.MONDAY);
		plan.addPeriod(Period.TUESDAY);
		plan.addPeriod(Period.WEDNESDAY);
		plan.addPeriod(Period.THURSDAY);
		plan.addPeriod(Period.FRIDAY);
		plan.addPeriod(Period.SATURDAY);
		plan.addPeriod(Period.SUNDAY);
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		plan.setNumberPerPeriod(1);
		plan.setFromDate(format.format(cal.getTime()));
		plan.addTime("10:00");
		plan.addAdvtime("0");
		plan.setComments("系统添加");
		plan.setCreateBy(String.valueOf(doctor.getId()));
		plan.setCreateDate(cal.getTime());
		planService.save(plan);
	}

	private void addDefaultFollowUpPlan(Doctor doctor, Patient patient) {
		Plan plan = new Plan();
		plan.setTitle("随访" + patient.getUserName());
		plan.setType(ProgramType.Followup);
		plan.setFromUser(patient);
		plan.setToUser(doctor);
		plan.addPeriod(Period.WEEK);
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		plan.setFromDate(format.format(cal.getTime()));
		plan.addTime("10:00");
		plan.addAdvtime("0");
		plan.setNumberPerPeriod(1);
		plan.setComments("电话:" + patient.getPhone());
		plan.setCreateBy(String.valueOf(doctor.getId()));
		plan.setCreateDate(cal.getTime());
		planService.save(plan);
	}

	private void addDefaultXrayPlan(Doctor doctor, Patient patient) throws ParseException {
		Plan plan = new Plan();
		plan.setTitle(patient.getUserName() + "胸透");
		plan.setType(ProgramType.XRay);
		plan.setFromUser(doctor);
		plan.setToUser(patient);
		plan.addPeriod(Period.ONCE);
		Calendar cal = Calendar.getInstance();
		plan.setCreateDate(cal.getTime());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		cal.setTime(format.parse(patient.getFirstTakeDate()));
		cal.add(Calendar.MONTH, +2);
		plan.setFromDate(format.format(cal.getTime()));
		plan.addTime("10:00");
		plan.addAdvtime("24");
		plan.setNumberPerPeriod(1);
		plan.setComments("电话:" + doctor.getPhone());
		plan.setCreateBy(String.valueOf(doctor.getId()));
		planService.save(plan);
		;
	}

	private void addRemindXrayPlan(Doctor doctor, Patient patient) throws ParseException {
		Plan plan = new Plan();
		plan.setTitle("提醒" + patient.getUserName() + "胸片检测");
		plan.setType(ProgramType.XRay);
		plan.setFromUser(doctor);
		plan.setToUser(doctor);
		plan.addPeriod(Period.ONCE);
		Calendar cal = Calendar.getInstance();
		plan.setCreateDate(cal.getTime());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		cal.setTime(format.parse(patient.getFirstTakeDate()));
		cal.add(Calendar.MONTH, +2);
		plan.setFromDate(format.format(cal.getTime()));
		plan.addTime("10:00");
		plan.addAdvtime("24");
		plan.setNumberPerPeriod(1);
		plan.setComments("电话:" + patient.getPhone());
		plan.setCreateBy(String.valueOf(doctor.getId()));
		planService.save(plan);
	}

	private void addDefaultSputumPlan(Doctor doctor, Patient patient) throws ParseException {
		Plan plan = new Plan();
		plan.setTitle(patient.getUserName() + "痰检");
		plan.setType(ProgramType.Sputum);
		plan.setFromUser(doctor);
		plan.setToUser(patient);
		plan.addPeriod(Period.ONCE);
		Calendar cal = Calendar.getInstance();
		plan.setCreateDate(cal.getTime());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		cal.setTime(format.parse(patient.getFirstTakeDate()));
		cal.add(Calendar.MONTH, +2);
		plan.setFromDate(format.format(cal.getTime()));
		plan.addTime("10:00");
		plan.addAdvtime("24");
		plan.setNumberPerPeriod(1);
		plan.setComments("电话:" + doctor.getPhone());
		plan.setCreateBy(String.valueOf(doctor.getId()));
		planService.save(plan);
	}

	private void addRemindSputumPlan(Doctor doctor, Patient patient) throws ParseException {
		Plan plan = new Plan();
		plan.setTitle("提醒" + patient.getUserName() + "痰检");
		plan.setType(ProgramType.Sputum);
		plan.setFromUser(doctor);
		plan.setToUser(doctor);
		plan.addPeriod(Period.ONCE);
		Calendar cal = Calendar.getInstance();
		plan.setCreateDate(cal.getTime());
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		cal.setTime(format.parse(patient.getFirstTakeDate()));
		cal.add(Calendar.MONTH, +2);
		plan.setFromDate(format.format(cal.getTime()));
		plan.addTime("10:00");
		plan.addAdvtime("24");
		plan.setNumberPerPeriod(1);
		plan.setComments("电话:" + patient.getPhone());
		plan.setCreateBy(String.valueOf(doctor.getId()));
		planService.save(plan);
	}

	// 未执行的计划
	private void notExcetuedPlan(ModelMap map, Doctor doctor) {
		// TODO 只判断了随访
		List<Plan> plans = planService.getPlans(doctor);
		List<Plan> notExcetuedPlans = new ArrayList<Plan>();
		for (Plan plan : plans) {
			if (ProgramType.Followup.equals(plan.getType())) {
				if (!executeService.isExecuted(plan)) {
					notExcetuedPlans.add(plan);
				}
			}
		}
		map.put("notExcetuedPlans", notExcetuedPlans);
	}

	// 未服药病人信息和异常报告
	private void noMedicineRecordPatients(ModelMap map, Doctor doctor, List<Patient> patients) {
		if (patients == null || patients.size() <= 0) {
			map.put("numOfNoMedToday", 0);
			map.put("numOfXray", 0);
			map.put("numOfSputum", 0);
			map.put("patients", new ArrayList<PatientInfo>());
			return;
		}
		StringBuilder idBuilder = new StringBuilder();
		for (Patient p : patients) {
			if (idBuilder.length() > 0) {
				idBuilder.append(",");
			}
			idBuilder.append(p.getId());
		}
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String today = format.format(cal.getTime());
		String taked = executeService.getTakedPatientIdListStr(idBuilder.toString(), today, ProgramType.Medicine);
		String abnormalXray = checkService.getAbnormalByPatientIDListStr(idBuilder.toString(), ProgramType.XRay);
		String abnormalSputum = checkService.getAbnormalByPatientIDListStr(idBuilder.toString(), ProgramType.Sputum);
		List<Patient> pp = executeService.getFollowUpPatients(doctor, today);
		String temp = "";
		List<Patient> noTakePatients = new ArrayList<Patient>();
		List<Patient> noFollowupToday = new ArrayList<Patient>();
		List<PatientInfo> patientInfo = new ArrayList<PatientInfo>();
		List<PatientCheck> listXray = new ArrayList<PatientCheck>();
		List<PatientCheck> listSputum = new ArrayList<PatientCheck>();
		Boolean isFollowupToday = false;
		StringBuilder builder = new StringBuilder(",");
		for (Patient followed : pp) {
			if (followed != null) {
				builder.append(followed.getId());
				builder.append(",");
			}
		}
		String followedIds = builder.toString();
		for (Patient patient : patients) {
			isFollowupToday = false;
			PatientInfo info = new PatientInfo();
			info.setPatientId(patient.getId());
			info.setPatientName(patient.getUserName());
			info.setPhone(patient.getPhone());
			info.setPhoto(patient.getPhoto());
			temp = "," + patient.getId() + ",";
			if (!taked.contains(temp)) {
				if (!followedIds.contains(temp)) {
					noTakePatients.add(patient);
				}
				for (Patient p : pp) {
					if (p != null) {
						if (p.getId() == patient.getId()) {
							isFollowupToday = true;
						}
					}
				}
				if (!isFollowupToday) {
					noFollowupToday.add(patient);
				}
				info.setTakenMedToday(false);
			} else {
				info.setTakenMedToday(true);
			}
			patientInfo.add(info);
			if ((abnormalXray.contains(temp))) {
				List<PatientCheck> checks = checkService.getCheckList(patient);
				for (PatientCheck patientCheck : checks) {
					if (patientCheck.getCheckType().equals(ProgramType.XRay) && patientCheck.getDisplay().equals(Display.Show)) {
						listXray.add(patientCheck);
					}
				}
			}
			if ((abnormalSputum.contains(temp))) {
				List<PatientCheck> checks = checkService.getCheckList(patient);
				for (PatientCheck patientCheck : checks) {
					if (patientCheck.getResult().equals(CheckResult.POSITIVE) && patientCheck.getCheckType().equals(ProgramType.Sputum)
							&& patientCheck.getDisplay().equals(Display.Show)) {
						listSputum.add(patientCheck);
					}
				}
			}
		}
		Integer numOfNoMedToday = noTakePatients.size();
		map.put("numOfNoMedToday", numOfNoMedToday);
		map.put("patients", patientInfo);
		map.put("numOfXray", listXray.size());
		LOG.info("getSputumByPatientIDListStr   size ===== " + listSputum.size());
		map.put("numOfSputum", listSputum.size());
	}

	@RequestMapping(value = "patients", method = RequestMethod.GET)
	public ModelAndView patients(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ModelMap map = new ModelMap();
		HttpSession session = request.getSession();
		Doctor doctor = (Doctor) session.getAttribute("doctor");
		List<Patient> patients = userService.getPatientsByDoctor(doctor);
		noMedicineRecordPatients(map, doctor, patients);
		return new ModelAndView("doctor/patients", map);
	}

	@RequestMapping(value = "addReiation", method = RequestMethod.GET)
	public ModelAndView addReiation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("doctor/addreiation", null);
	}

	@RequestMapping(value = "saveRelation", method = RequestMethod.POST)
	public String saveRelation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, ParseException {
		String patientName = request.getParameter("patientName");
		String identifier = request.getParameter("identifier");
		String pillBoxID = request.getParameter("pillBoxID");
		String language = request.getParameter("language");
		String registrationDate = request.getParameter("registrationDate");
		String firstTakeDate = request.getParameter("firstTakeDate");
		return addreiation("redirect:/doctor/patients", request, identifier, patientName, pillBoxID, language, registrationDate, firstTakeDate);
	}

	@RequestMapping(value = "plans", method = RequestMethod.GET)
	public ModelAndView plans(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ModelMap map = new ModelMap();
		HttpSession session = request.getSession();
		Doctor doctor = (Doctor) session.getAttribute("doctor");
		notExcetuedPlan(map, doctor);
		return new ModelAndView("doctor/plans", map);
	}

	@RequestMapping(value = "reports", method = RequestMethod.GET)
	public ModelAndView reports(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ModelMap map = new ModelMap();
		HttpSession session = request.getSession();
		Doctor doctor = (Doctor) session.getAttribute("doctor");
		List<Patient> patients = userService.getPatientsByDoctor(doctor);
		noMedicineRecordPatients(map, doctor, patients);
		return new ModelAndView("doctor/reports", map);
	}
	
	@RequestMapping(value = "getNotice", method = RequestMethod.GET)
	public ModelAndView getNotice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
		String noticeType = request.getParameter("noticeType");
		ModelMap map = new ModelMap();
		map.put("noticeType", noticeType);
		Notice notice = noticeService.findById(id);
		List<Article> list = articleService.getNoticeId(notice.getNoticeId());
		map.put("notice", notice);
		map.put("list", list);
		return new ModelAndView("doctor/getNotice", map);
	}
}
