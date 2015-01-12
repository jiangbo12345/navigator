
package com.xhr.controller.patient;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

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
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.User;
import com.xhr.service.*;
import com.xhr.util.Util;

@Controller
@RequestMapping("/patient")
public class PatientIndexController {

    private static final Logger LOG = Logger.getLogger(PatientIndexController.class);
    @Autowired
    IUserService userService;

    @Autowired
    IMessageService messageService;

    @Autowired
    IPlanService planService;

    @Autowired
    IPatientCheckService checkService;

    @Autowired
    IExecuteService executeService;

    @RequestMapping(value = "index", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ModelMap map = new ModelMap();
        Patient patient = (Patient) session.getAttribute("patient");
        List<Message> toDoMessages = messageService.getToDoList(patient);
        List<PatientCheck> patChecks = checkService.getCheckList(patient);
        Object obj = session.getAttribute("doctor");
        if (obj != null) {
            Doctor doctor = (Doctor) obj;
            List<Message> doctorAddMessages = new ArrayList<Message>();
            for (Message message : toDoMessages) {
                if (message.getFrom() != null && message.getFrom().getId() == doctor.getId()) {
                    doctorAddMessages.add(message);
                }
            }
            map.put("toDoMessages", doctorAddMessages);
        } else {
            map.put("toDoMessages", toDoMessages);
        }
        Map<String, Map<String, List<Doctor>>> doctors = Util.getArrayByDoctors(patient.getDoctors());
        User loginUser = (User) session.getAttribute("loginUser");
        map.put("loginUser", loginUser);
        map.put("patient", patient);
        map.put("patientChecks", patChecks);
        map.put("hospital", doctors);
        cal(map, patient, request);
        return new ModelAndView("patient/index", map);
    }

    private void cal(ModelMap map, Patient patient, HttpServletRequest request) {
        String[] days = new String[42];
        String[] bjcolors = new String[42];
        String[] ftcolors = new String[42];
        String[] ftclasses = new String[42];
        String showMonth = request.getParameter("showMonth");
        String previousMonth = "";
        String nextMonth = "";
        int year = 0;
        int month = 0;
        if (showMonth == null || showMonth.isEmpty()) {
            GregorianCalendar currentDay = new GregorianCalendar();
            year = currentDay.get(Calendar.YEAR);
            month = currentDay.get(Calendar.MONTH);// 月，由于取值范围为0-11，实际月份需+1
            showMonth = year + "-" + (month + 1); // 得到标准日历系统的当前时间输出字符串
            previousMonth = year + "-" + (month < 10 ? "0" : "") + month;
            nextMonth = year + "-" + ((month + 2) < 10 ? "0" : "") + (month + 2);
        } else {
            String[] mm = showMonth.split("-");
            year = Integer.parseInt(mm[0]);
            month = Integer.parseInt(mm[1]);
            if (month == 1) {
                previousMonth = (year - 1) + "-12";
                nextMonth = year + "-" + ((month + 1) < 10 ? "0" : "") + (month + 1);
            } else if (month == 12) {
                previousMonth = year + "-" + ((month - 1) < 10 ? "0" : "") + (month - 1);
                nextMonth = (year + 1) + "-01";
            } else {
                previousMonth = year + "-" + ((month - 1) < 10 ? "0" : "") + (month - 1);
                nextMonth = year + "-" + ((month + 1) < 10 ? "0" : "") + (month + 1);
            }
            month = Integer.parseInt(mm[1]) - 1;

        }

        // 创建日历
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.MONTH, month);// 月份为当前月
        calendar.set(Calendar.YEAR, year);// 年份为当前年
        calendar.setFirstDayOfWeek(Calendar.MONDAY);// 每周第一天为星期日
        calendar.set(Calendar.DAY_OF_MONTH, 1);// 该月的第一天
        int firstIndex = calendar.get(Calendar.DAY_OF_WEEK) - 1;// 第一天的星期
        int maxIndex = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);// 这个月最大天数

        StringBuilder builder = new StringBuilder("");
        List<ExecuteRecord> records = executeService.getRecordMonthly(patient, String.valueOf(year), String.valueOf(month + 1));
        for (ExecuteRecord record : records) {
            builder.append(",");
            builder.append(record.getExecuteDate().substring(8));
        }
        String takeDays = builder.toString();

        builder = new StringBuilder("");
        int noOfVisitDays = 0;
        List<ExecuteRecord> followups = executeService.getFollowupMonthly(patient, String.valueOf(year), String.valueOf(month + 1));
        for (ExecuteRecord followup : followups) {
            builder.append(",");
            builder.append(followup.getExecuteDate().substring(8));
            noOfVisitDays++;
        }
        String vaistDays = builder.toString();
        int noOfTakeDays = 0;

        // 得到该月日数字符串

        for (int i = 0; i < maxIndex; i++) {
            // int需转换为字符串
            if (i < 9) {
                days[firstIndex + i] = "0" + String.valueOf(i + 1);
            } else {
                days[firstIndex + i] = String.valueOf(i + 1);
            }
            if (days[firstIndex + i].length() > 0) {
                if (takeDays.contains(days[firstIndex + i])) {
                    bjcolors[firstIndex + i] = "dff0d8";
                    noOfTakeDays++;
                } else {
                    bjcolors[firstIndex + i] = "dddddd";
                }

                if (vaistDays.contains(days[firstIndex + i])) {
                    ftclasses[firstIndex + i] = "round";

                }
            }
            ftcolors[firstIndex + i] = "#FFFFFF";
        }

        map.put("firstIndex", firstIndex);
        map.put("previousMonth", previousMonth);
        map.put("showMonth", showMonth);
        map.put("nextMonth", nextMonth);
        map.put("days", days);
        map.put("bjcolor", bjcolors);
        map.put("ftcolor", ftcolors);
        map.put("ftclass", ftclasses);
        map.put("noOfTakeDays", noOfTakeDays);
        map.put("noOfVisitDays", noOfVisitDays);
        map.put("noOfNonTakeDays", maxIndex - noOfTakeDays);
        System.out.println("================");
        System.out.println(previousMonth);
        System.out.println(nextMonth);
        System.out.println("================");
    }

    @RequestMapping(value = "addToDoMessage", method = RequestMethod.POST)
    public String addToDoMessage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String content = request.getParameter("todoMessage");
        HttpSession session = request.getSession();
        Patient patient = (Patient) session.getAttribute("patient");
        Message message = new Message();
        message.setContent(content);
        User loginUser = (User) session.getAttribute("loginUser");
        message.setFrom(loginUser);
        message.setSendTo(patient);
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

    @RequestMapping(value = "deletePatientCheck", method = RequestMethod.GET)
    public String deletePatientCheck(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer checkId = Integer.parseInt(request.getParameter("id"));
        PatientCheck check = checkService.findById(checkId);
        boolean isok = checkService.delete(checkId);
        if (isok) {
            if (check.getFilePath() != null || !check.getFilePath().equals("")) {
                String logoRealPathDir = request.getSession().getServletContext().getRealPath(check.getFilePath());
                File file = new File(logoRealPathDir);
                File fileParent = file.getParentFile();
                if (file.getParentFile() != null) {
                    boolean isDelete = file.delete();
                    if (isDelete) {
                        if (fileParent.listFiles().length == 0) {
                            fileParent.delete();
                        }
                    }
                }
            }
        }
        return "redirect:index";
    }

    @RequestMapping(value = "updateFollowUpPlan", method = RequestMethod.POST)
    public String updateFollowUpPlan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String period = request.getParameter("period");
        Integer planId = Integer.parseInt(request.getParameter("planId"));
        Integer numPerPeriod = Integer.parseInt(request.getParameter("numPerPeriod"));
        Plan plan = planService.findById(planId);
        plan.addPeriod(Period.valueOf(period));
        planService.update(plan);
        return "redirect:index";
    }
    
    @RequestMapping(value = "getXraysByPatient", method = RequestMethod.GET)
	public ModelAndView getXrays(Integer id,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
    	User user = userService.getPatientById(id);
		List<PatientCheck> checks = checkService.getCheckList(user,ProgramType.XRay);
		System.out.println("jiangbo  size = - == == "+checks.size());
		ModelMap map = new ModelMap();
		map.put("checks", checks);
		return new ModelAndView("patient/patientXray", map);
	}
    
    @RequestMapping(value = "getSputumsByPatient", method = RequestMethod.GET)
	public ModelAndView getSputums(Integer id,HttpServletRequest request,
			HttpServletResponse response) throws Exception {
    	User user = userService.getPatientById(id);
		List<PatientCheck> checks = checkService.getCheckList(user,ProgramType.Sputum);
		System.out.println("jiangbo  size = - == == "+checks.size());
		ModelMap map = new ModelMap();
		map.put("checks", checks);
		return new ModelAndView("patient/patientSputum", map);
	}
}
