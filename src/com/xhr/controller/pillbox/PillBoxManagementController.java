package com.xhr.controller.pillbox;

import java.io.IOException;
import java.util.List;

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
import com.xhr.service.IPillBoxService;

@Controller
@RequestMapping("admin")
public class PillBoxManagementController {
	@Autowired
	IPillBoxService pillBoxService;

	@RequestMapping(value = "pillBoxList", method = RequestMethod.GET)
	public ModelAndView pillBoxList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		List<PillBox> list = pillBoxService.getAll();
		ModelMap map = new ModelMap();
		map.put("pillBoxList", list);
		return new ModelAndView("admin/pillBoxList", map);
	}
	@RequestMapping(value = "searchPillBox", method = RequestMethod.POST)
	public ModelAndView search(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String identifier = request.getParameter("identifier");
		String st = request.getParameter("state");
		State state = null;
		if (!st.equals("")) {
			state = State.valueOf(st);
		}
		List<PillBox> list = pillBoxService.getListByIdentAndState(identifier,state);
		ModelMap map = new ModelMap();
		map.put("pillBoxList", list);
		return new ModelAndView("admin/pillBoxList", map);
	}
	
}
