
package com.xhr.controller.patient;

import java.io.IOException;
import java.util.List;
import java.util.Map;

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

import com.xhr.entity.PatientCheck;
import com.xhr.entity.Plan;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.User;
import com.xhr.service.IPatientCheckService;
import com.xhr.util.Util;

@Controller
@RequestMapping("/patient")
public class EMRController {

    @Autowired
    IPatientCheckService checkService;

    @RequestMapping(value = "emr", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/emr", getMap(request));
    }

    @RequestMapping(value = "bloodpress", method = RequestMethod.GET)
    public ModelAndView bloodpress(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/bloodpress", getMap(request));
    }

    @RequestMapping(value = "healthplan", method = RequestMethod.GET)
    public ModelAndView plan(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/healthplan", getMap(request));
    }
    
    @RequestMapping(value = "message", method = RequestMethod.GET)
    public ModelAndView message(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/message", getMap(request));
    }

    @RequestMapping(value = "rule", method = RequestMethod.GET)
    public ModelAndView tule(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/rule", getMap(request));
    }

    @RequestMapping(value = "reminder", method = RequestMethod.GET)
    public ModelAndView reminder(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/reminder", getMap(request));
    }

    @RequestMapping(value = "todo", method = RequestMethod.GET)
    public ModelAndView todo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/todo", getMap(request));
    }

    @RequestMapping(value = "reminderRecord", method = RequestMethod.GET)
    public ModelAndView reminderRecord(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/reminderRecord", getMap(request));
    }

    @RequestMapping(value = "ruleRecord", method = RequestMethod.GET)
    public ModelAndView ruleRecord(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("patient/ruleRecord", getMap(request));
    }

    private ModelMap getMap(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ModelMap map = new ModelMap();
        Patient patient = (Patient) session.getAttribute("patient");
        Map<String, Map<String, List<Doctor>>> doctors = Util.getArrayByDoctors(patient.getDoctors());
        User loginUser = (User) session.getAttribute("loginUser");
        List<PatientCheck> patChecks = checkService.getCheckList(patient);
        map.put("loginUser", loginUser);
        map.put("patient", patient);
        map.put("hospital", doctors);
        map.put("patientChecks", patChecks);
        return map;
    }
}
