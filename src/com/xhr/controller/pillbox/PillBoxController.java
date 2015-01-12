package com.xhr.controller.pillbox;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.xhr.entity.PillBox;
import com.xhr.entity.State;
import com.xhr.entity.user.Patient;
import com.xhr.service.IPillBoxService;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("/pillBox")
public class PillBoxController {

	@Autowired
	IPillBoxService pillBoxService;
	
	@Autowired
	IUserService userService;

	@RequestMapping(value = "add", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("pillbox/addPillBox", null);
	}

	@RequestMapping(value = "update", method = RequestMethod.GET)
	public ModelAndView update(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String identifier = request.getParameter("identifier");
		PillBox pillBox = pillBoxService.findById(identifier);
		ModelMap map = new ModelMap();
		map.put("pillBox", pillBox);
		return new ModelAndView("pillbox/updatePillBox", map);
	}

	@RequestMapping(value = "savePillBox", method = RequestMethod.POST)
	public String saveTakeRecord(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String identifier = request.getParameter("identifier");
		String version = request.getParameter("version");
		String serverAddress = request.getParameter("serverAddress");
		String serverPort = request.getParameter("serverPort");
		String serverAPN = request.getParameter("serverAPN");
		State state = State.valueOf(request.getParameter("state"));
		String difference = request.getParameter("difference");
		System.out.println("difference============" + difference);
		System.out.println("identifier============" + identifier);
		PillBox pillBox = pillBoxService.findById(identifier);
		if (pillBox == null) {
			pillBox = new PillBox();
			pillBox.setIdentifier(identifier);
			pillBox.setState(state);
		}
		pillBox.setServerAddress(serverAddress);
		pillBox.setServerAPN(serverAPN);
		pillBox.setServerPort(serverPort);
		pillBox.setVersion(version);
		pillBoxService.save(pillBox);
		if (difference.equals("add")) {
			System.out.println("药盒病信息新增！！");
			pillBoxService.save(pillBox);
			return "redirect:/admin/pillBoxList";
		} else {
			if (pillBox.getState()==State.ENABLE) {
				System.out.println("药盒病信息更改！！"+pillBox.getIdentifier());
				Patient patient = userService.getPatientByPillBox(pillBox);
				if (patient!=null) {
					System.out.println("信息更改===="+patient.getIdentifier());
					patient.setPillBox(null);
					boolean isok = userService.update(patient);
					if (isok) {
						System.out.println("药盒病人绑定解除！！");
						pillBox.setState(state);
					}
				}
			}else{
				System.out.println("药盒病人绑定解除！！");
				pillBox.setState(state);
			}
			PillBox Box = pillBoxService.update(pillBox);
			ModelMap map = new ModelMap();
			map.put("pillBox", Box);
			return "redirect:/admin/pillBoxList";
		}

	}
}
