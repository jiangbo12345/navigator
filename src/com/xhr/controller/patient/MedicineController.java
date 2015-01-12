
package com.xhr.controller.patient;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.xhr.entity.ExecuteRecord;
import com.xhr.entity.ProgramType;
import com.xhr.entity.user.Patient;
import com.xhr.service.IExecuteService;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("/medicine")
public class MedicineController {

    private static final Logger LOG = Logger.getLogger(MedicineController.class);

    @Autowired
    IExecuteService executeService;
    @Autowired
    IUserService userService;

    @RequestMapping(value = "add", method = RequestMethod.GET)
    public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("medicine/addTakeRecord", null);
    }

    @RequestMapping(value = "saveTakeRecord", method = RequestMethod.POST)
    public String saveTakeRecord(ExecuteRecord record, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Patient patient = (Patient) session.getAttribute("patient");
        record.setExecutor(patient);
        record.setType(ProgramType.Medicine);
        LOG.info("save the take record" + record.getExecuteDate());
        executeService.save(record);
        return "redirect:/patient/index";
    }

}
