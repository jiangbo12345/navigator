
package com.xhr.controller.doctor;

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

import com.xhr.entity.Plan;
import com.xhr.entity.user.Doctor;
import com.xhr.service.IPlanService;

@Controller
@RequestMapping("/doctor")
public class DoctorPlanController {

    @Autowired
    IPlanService planService;

    @RequestMapping(value = "listplan", method = RequestMethod.GET)
    public ModelAndView list(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ModelMap map = new ModelMap();
        Doctor doctor = (Doctor) session.getAttribute("doctor");
        List<Plan> plans = planService.getPlans(doctor);
        map.put("plans", plans);
        return new ModelAndView("doctor/listplan", map);
    }
}
