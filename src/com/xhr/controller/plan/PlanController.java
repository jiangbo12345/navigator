package com.xhr.controller.plan;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.xhr.entity.ExecuteRecord;
import com.xhr.entity.Plan;
import com.xhr.entity.ProgramType;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Role;
import com.xhr.entity.user.User;
import com.xhr.service.IExecuteService;
import com.xhr.service.IPlanService;

@Controller
@RequestMapping("/plan")
public class PlanController {

	@Autowired
	IPlanService planService;

	@Autowired
	IExecuteService executeService;

	@RequestMapping(value = "listplan", method = RequestMethod.GET)
	public ModelAndView listPlan(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ModelMap map = new ModelMap();
		String change = request.getParameter("rolechange");
		User user;
		if ("true".equals(change)) {
			user = (User) session.getAttribute("patient");
			map.put("rolechange", "true");
		} else {
			user = (User) session.getAttribute("loginUser");
			map.put("rolechange", "");
		}
		List<Plan> plans = planService.getPlans(user);
		map.put("plans", plans);

		return new ModelAndView("plan/planlist", map);
	}

	@RequestMapping(value = "planList", method = RequestMethod.GET)
	public ModelAndView planList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ModelMap map = new ModelMap();
		User user = (User) session.getAttribute("loginUser");
		map.put("rolechange", "");
		List<Plan> plans = planService.getPlansByDoctor((Doctor) user);
		map.put("plans", plans);
		return new ModelAndView("plan/planlist", map);
	}

	@RequestMapping(value = "getPlan", method = RequestMethod.GET)
	public ModelAndView getPlan(Integer id, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ModelMap map = new ModelMap();
		Plan plan = planService.findById(id);
		map.put("plan", plan);
		return new ModelAndView("plan/planShow", map);
	}

	@RequestMapping(value = "addPlan", method = RequestMethod.GET)
	public ModelAndView addPlan(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ModelMap map = new ModelMap();
		User loginUser = (User) session.getAttribute("loginUser");
		map.put("loginUser", loginUser);
		String change = request.getParameter("rolechange");
		if ("true".equals(change)) {
			map.put("rolechange", "true");
		} else {
			map.put("rolechange", "");
		}
		return new ModelAndView("plan/addplan", map);
	}

	@RequestMapping(value = "savePlan", method = RequestMethod.POST)
	public String savePlan(Plan plan, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		plan.setFromUser(loginUser);
		plan.setToUser(loginUser);
		String change = request.getParameter("rolechange");
		if ("true".equals(change)) {
			plan.setTitle(plan.getTitle() + "(" + loginUser.getUserName() + ")");
			User patient = (User) session.getAttribute("patient");
			plan.setToUser(patient);
		}
		plan.setCreateBy(String.valueOf(loginUser.getId()));
		plan.setCreateDate(new Date());
		List<String> times = new ArrayList<String>();
		List<String> advtime = new ArrayList<String>();
		for (int i = 0; i < plan.getTimes().size(); i++) {
			if (!plan.getTimes().get(i).isEmpty()) {
				times.add(plan.getTimes().get(i));
				advtime.add(plan.getAdvtime().get(i));
			}
		}
		if (times.size() > 0) {
			plan.setAdvtime(advtime);
			plan.setTimes(times);
		}
		planService.save(plan);
		if (change.equals("") && loginUser.getRole().equals(Role.DOCTOR)) {
			return "redirect:/plan/listplan";
		}
		return "redirect:/plan/listplan?rolechange=" + change;
	}

	@RequestMapping(value = "updatePlan", method = RequestMethod.POST)
	public String updatePlan(Plan plan, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		plan.setFromUser(loginUser);
		plan.setToUser(loginUser);
		Plan p = planService.findById(plan.getId());
		List<String> times = new ArrayList<String>();
		List<String> advtime = new ArrayList<String>();
		String change = request.getParameter("rolechange");
		if ("true".equals(change)) {
			plan.setTitle(plan.getTitle());
			User patient = (User) session.getAttribute("patient");
			plan.setToUser(patient);
		}
		for (int i = 0; i < plan.getTimes().size(); i++) {
			if (!plan.getTimes().get(i).isEmpty()) {
				times.add(plan.getTimes().get(i));
				advtime.add(plan.getAdvtime().get(i));
			}
		}
		if (times.size() > 0) {
			plan.setAdvtime(advtime);
			plan.setTimes(times);
		}
		plan.setCreateDate(p.getCreateDate());
		plan.setCreateBy(p.getCreateBy());
		BeanUtils.copyProperties(plan, p);
		planService.update(p);
		planService.save(plan);
		if (change.equals("") && loginUser.getRole().equals(Role.DOCTOR)) {
			return "redirect:/plan/listplan";
		}
		return "redirect:/plan/listplan?rolechange=" + change;
	}

	@RequestMapping(value = "deletePlan", method = RequestMethod.GET)
	public String deletePlan(Integer id, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		planService.delete(id);
		String change = request.getParameter("rolechange");
		if (change.equals("") && loginUser.getRole().equals(Role.DOCTOR)) {
			return "redirect:/plan/listplan";
		}
		return "redirect:/plan/listplan?rolechange=" + change;
	}

	@RequestMapping(value = "updaterPlan", method = RequestMethod.GET)
	public ModelAndView updaterPlan(Integer id, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Plan plan = planService.findById(id);
		String change = request.getParameter("rolechange");
		HttpSession session = request.getSession();
		ModelMap map = new ModelMap();
		User loginUser = (User) session.getAttribute("loginUser");
		map.put("loginUser", loginUser);
		if ("true".equals(change)) {
			map.put("rolechange", "true");
		} else {
			map.put("rolechange", "");
		}
		map.put("plan", plan);
		return new ModelAndView("plan/updatePlan", map);
	}

	@RequestMapping(value = "execute", method = RequestMethod.GET)
	public ModelAndView executePage(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ModelMap map = new ModelMap();
		map.put("planId", request.getParameter("planId"));
		System.out.println("request.getParameter(page)==="
				+ request.getParameter("page"));
		map.put("page", request.getParameter("page"));
		return new ModelAndView("plan/execute", map);
	}

	@RequestMapping(value = "execute", method = RequestMethod.POST)
	public ModelAndView executePlan(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		ModelMap map = new ModelMap();
		String planId = request.getParameter("planId");
		String page = request.getParameter("page");
		Plan plan = planService.findById(Integer.parseInt(planId));
		String comment = request.getParameter("comment");
		ExecuteRecord record = new ExecuteRecord();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		System.out.println("plan.getType()=======" + plan.getType());
		if (plan.getType().equals(ProgramType.Medicine)) {
			plan.setType(ProgramType.Followup);
			record.setType(plan.getType());
			record.setExecutor(plan.getFromUser());
			record.setAimUser(plan.getToUser());
		}else{
			record.setType(plan.getType());
			record.setExecutor(plan.getToUser());
			record.setAimUser(plan.getFromUser());
		}
		record.setExecuteDate(format.format(cal.getTime()));
		format = new SimpleDateFormat("HH:mm");
		record.setExecuteTime(format.format(cal.getTime()));
		record.setComments(comment);
		executeService.save(record);
		map.put("isok", page);
		return new ModelAndView("plan/execute", map);
	}
}
