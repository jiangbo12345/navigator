package com.xhr.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.xhr.entity.BaseGeographic;
import com.xhr.service.IBaseGeographicService;

@Controller
@RequestMapping("/getaddress")
public class GetAddress {

	@Autowired
	IBaseGeographicService baseGeographicService;
	
	@RequestMapping(value = "getAdd", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getAdd(@RequestParam(value = "id", required = true) Integer id, HttpServletRequest request) throws ServletException, IOException {
		List<BaseGeographic> list = new ArrayList<BaseGeographic>();
		if (id != -1) {
			 list = baseGeographicService.getParentByID(id);
		}
		ModelMap map = new ModelMap();
		System.out.println("addresslist======="+list.size());
		map.put("address", list);
		map.put("success", "true");
		return map;
	}
}
