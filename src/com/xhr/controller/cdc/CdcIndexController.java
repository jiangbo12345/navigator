package com.xhr.controller.cdc;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.xhr.entity.Article;
import com.xhr.entity.BaseGeographic;
import com.xhr.entity.CdcOrganization;
import com.xhr.entity.Hospital;
import com.xhr.entity.Notice;
import com.xhr.entity.NoticeType;
import com.xhr.entity.PropagandaDatum;
import com.xhr.entity.PropagandaIssued;
import com.xhr.entity.user.Address;
import com.xhr.entity.user.Cdc;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.User;
import com.xhr.model.UserNames;
import com.xhr.service.IArticleService;
import com.xhr.service.IBaseGeographicService;
import com.xhr.service.ICdcOrganizationService;
import com.xhr.service.INoticeService;
import com.xhr.service.IPropagandaDatumService;
import com.xhr.service.IPropagandaIssuedService;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("/cdc")
public class CdcIndexController {

	@Autowired
	IBaseGeographicService baseGeographicService;

	@Autowired
	ICdcOrganizationService cdcOrganizationService;

	@Autowired
	IUserService userService;

	@Autowired
	INoticeService noticeService;

	@Autowired
	IArticleService articleService;
	
	@Autowired
	IPropagandaIssuedService propIssuedService;
	
	@Autowired
	IPropagandaDatumService propDatumService;

	@RequestMapping(value = "index", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ModelMap map = new ModelMap();
		HttpSession session = request.getSession();
		Cdc cdc = (Cdc) session.getAttribute("cdc");
		List<Notice> list = noticeService.getNoticeByDoc((User)cdc);
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
		return new ModelAndView("cdc/index", map);
	}

	@RequestMapping(value = "notice", method = RequestMethod.GET)
	public ModelAndView notice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Notice> list = noticeService.getAll();
		List<Article> articles = articleService.getAll();
		ModelMap map = new ModelMap();
		map.put("list", list);
		map.put("articles", articles);
		return new ModelAndView("cdc/notice", map);
	}

	@RequestMapping(value = "map", method = RequestMethod.GET)
	public ModelAndView map(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("cdc/map", null);
	}

	@RequestMapping(value = "getTo", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getTo(@RequestParam(value = "who", required = true) String who, HttpServletRequest request) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ModelMap map = new ModelMap();
		Cdc cdc = (Cdc) session.getAttribute("loginUser");
		if (who.equals("doctor")) {
			if (cdc.getCdcOrg() != null) {
				List<Hospital> list = cdc.getCdcOrg().getHospital();
				List<Doctor> doctors = new ArrayList<Doctor>();
				for (Hospital hospital : list) {
					if (hospital != null) {
						List<Doctor> docts = hospital.getDoctors();
						for (Doctor doctor : docts) {
							doctors.add(doctor);
						}
					}
				}
				map.put("doctors", doctors);
				map.put("success", "true");
			}
		} else if (who.equals("cdc")) {
			if (cdc.getCdcOrg() != null) {
				CdcOrganization cdcorg = cdc.getCdcOrg();
				Address add = cdcorg.getAddress();
				System.out.println(add.getProvience()+"  == "+add.getCity()+"  "+add.getDistrict());
				if (add.getDistrict() != null ) {
					List<Cdc> list = userService.getCdcByAddress("district", add.getDistrict());
					map.put("cdcs", list);
					map.put("success", "true");
					return map;
				} else if (add.getCity() != null) {
					List<Cdc> list = userService.getCdcByAddress("city", add.getCity());
					map.put("cdcs", list);
					map.put("success", "true");
					return map;
				} else if (add.getProvience() != null ) {
					List<Cdc> list = userService.getCdcByAddress("provience", add.getProvience());
					map.put("cdcs", list);
					map.put("success", "true");
					return map;
				}
			}
		} else if (who.equals("tag")) {

		}
		return map;
	}
	
	@RequestMapping(value = "getWho", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> getWho(@RequestParam(value = "ids", required = true) String ids ) throws ServletException, IOException {
		System.out.println("ids==========="+ids);
		String[] id = ids.split(",");
		String names = "";
		for (int i = 0; i < id.length; i++) {
			if (!id[i].equals("")) {
				User user =  userService.getUserByID(Integer.parseInt(id[i]));
				names = names +user.getUserName()+",";
			}
		}
		names = names.substring(0,names.length()-1);
		UserNames use = new UserNames();
		use.setUserNames(names);
		System.out.println("names=========="+names);
		System.out.println("use=========="+use.getUserNames());
		ModelMap map = new ModelMap();
		map.put("names", use);
		map.put("success", "true");
		return map;
	}
	
	@RequestMapping(value = "addNotice", method = RequestMethod.GET)
	public ModelAndView addNotice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("cdc/sendNotice", null);
	}

	@RequestMapping(value = "sendNotice", method = RequestMethod.POST)
	public String sendNotice(@RequestParam("sendFile") MultipartFile sendFile,@RequestParam("sendFile2") MultipartFile sendFile2, Notice notice, Article article, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String noticeType = request.getParameter("noticeType");
		NoticeType type = NoticeType.valueOf(noticeType);
		String cdcids = request.getParameter("cdcIDS");
		String docids = request.getParameter("docIDs");
		String id = ",";
		if (docids !=null && !docids.equals("")) {
			String[] str1 = docids.split(",");
			for (String docid : str1) {
				id = id + Integer.parseInt(docid.trim())+",";
			}
			
		}
		if (cdcids != null && !cdcids.equals("")) {
			String[] str2 = cdcids.split(",");
			for (String docid : str2) {
				id = id + Integer.parseInt(docid.trim())+",";
			}
		}
		System.out.println("id============="+id);
		notice.setNoticeDate((new SimpleDateFormat("yyyy-MM-dd")).format(new Date()));
			if (type == NoticeType.text) {
				if (!id.equals("")) {
					notice.setTouser(id);
					notice.setNoticeType(type);
					System.out.println("request.getParameter contentText==="+request.getParameter("contentText"));
					notice.setContent(request.getParameter("contentText"));
					noticeService.save(notice);
				}
			} else if (type == NoticeType.voice) {
				if (!id.equals("")) {
					notice.setTouser(id);
					notice.setNoticeType(type);
					String name = sendFile.getOriginalFilename();
					String pathDir = "/content/static/img/cdc/" +(new SimpleDateFormat("yyyyMMddHHmmss")).format(new Date()) + "/";
					String logoRealPathDir = request.getSession().getServletContext().getRealPath(pathDir);
					File file1 = new File(logoRealPathDir);
					if (!file1.exists())
						file1.mkdirs();
					File file = new File(logoRealPathDir, name);
					if (file.getParentFile() == null)
						file.mkdirs();
					sendFile.transferTo(file);
					notice.setPath(pathDir + name);
					notice.setContent(file.getAbsolutePath());
					noticeService.save(notice);
				}
			} else if (type == NoticeType.news) {
				if (!id.equals("")) {
					notice.setTouser(id);
					System.out.println("request.getParameter(contentNews)====="+request.getParameter("contentNews"));
					notice.setContent(request.getParameter("contentNews"));
					notice.setNoticeType(type);
					Notice not = noticeService.save(notice);
					String name = sendFile2.getOriginalFilename();
					String pathDir = "/content/static/img/cdc/" + not.getNoticeId() + "/";
					String logoRealPathDir = request.getSession().getServletContext().getRealPath(pathDir);
					File file1 = new File(logoRealPathDir);
					if (!file1.exists())
						file1.mkdirs();
					File file = new File(logoRealPathDir, name);
					if (file.getParentFile() == null)
						file.mkdirs();
					sendFile2.transferTo(file);
					article.setPicurl(file.getAbsolutePath());
					System.out.println("pathDir+name=================" + pathDir + name);
					article.setPath(pathDir + name);
					article.setNotice(not);
					articleService.save(article);
				}
			}
		
		return "redirect:/cdc/notice";
	}

	@RequestMapping(value = "deleteNotice", method = RequestMethod.GET)
	public String deleteNotice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Integer id = Integer.parseInt(request.getParameter("id"));
		Notice notice = noticeService.findById(id);
		List<Article> list = articleService.getNoticeId(notice.getNoticeId());
		for (Article article : list) {
			articleService.delete(article.getId());
		}
		noticeService.delete(id);
		return "redirect:/cdc/notice";
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
		return new ModelAndView("cdc/getNotice", map);
	}
	 
	@RequestMapping(value = "propIssuedList", method = RequestMethod.GET)
	public ModelAndView propIssuedList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<PropagandaIssued> list = propIssuedService.getAll();
		ModelMap map = new ModelMap();
		map.put("list", list);
		return new ModelAndView("cdc/propagandaIssued", map);
	}

	@RequestMapping(value = "addIssued", method = RequestMethod.GET)
	public ModelAndView addIssued(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<BaseGeographic> list = baseGeographicService.getBasicsGeographicNodes();
		List<CdcOrganization> cdcOrgs = cdcOrganizationService.getAll();
		List<PropagandaDatum> propDatums = propDatumService.getAll();
		HttpSession session = request.getSession();
		Cdc cdc = (Cdc)session.getAttribute("cdc");
	    Address address = cdc.getCdcOrg().getAddress();
		ModelMap map = new ModelMap();
		map.put("list", list);
		map.put("cdcOrgs", cdcOrgs);
		map.put("propDatums", propDatums);
		map.put("prov", address.getProvience());
		map.put("city", address.getCity());
		map.put("district", address.getDistrict());
		map.put("street", address.getStreet());
		return new ModelAndView("cdc/addPropIssued", map);
	}

	@RequestMapping(value = "saveIssued", method = RequestMethod.POST)
	public String saveIssued(PropagandaIssued propIssued, Address address, HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		String provience = baseGeographicService.getBaseGeographicByID(request.getParameter("provience")).getGeogDesignation();
		String city = baseGeographicService.getBaseGeographicByID(request.getParameter("city")).getGeogDesignation();
		String district = baseGeographicService.getBaseGeographicByID(request.getParameter("district")).getGeogDesignation();
		String street = baseGeographicService.getBaseGeographicByID(request.getParameter("street")).getGeogDesignation();
		address.setProvience(provience);
		address.setCity(city);
		address.setDistrict(district);
		address.setStreet(street);
		System.out.println("propIssued.getLanguage()==="+propIssued.getLanguage());
		List<Patient> list = userService.getPatientByAddress(address,propIssued.getLanguage());
		System.out.println("list.size()xxxxfff========="+list.size());
		if (list.size()>0 && !request.getParameter("datum").equals("-1")) {
			HttpSession session =  request.getSession();
			Cdc cdc = (Cdc)session.getAttribute("cdc");
			PropagandaDatum datum = null;
			if (request.getParameter("datum") != null && !request.getParameter("datum").equals("-1")) {
				datum = propDatumService.findById(Integer.parseInt(request.getParameter("datum")));
			}
			propIssued.setCdc(cdc);
			propIssued.setAddress(address);
			propIssued.setIssuedDate((new SimpleDateFormat("yyyy-MM-dd")).format(new Date()));
			propIssued.setPropDatum(datum);
			propIssued.setNotified(false);
			PropagandaIssued issued = propIssuedService.save(propIssued);
			issued.setPatients(list);
			propIssuedService.update(issued);
			return "redirect:/cdc/propIssuedList";
		}else{
			return "redirect:/cdc/errNoctice";
		}
	}
	
	@RequestMapping(value = "errNoctice", method = RequestMethod.GET)
	public ModelAndView errNoctice(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("cdc/errNoctice",null);
	}
	@RequestMapping(value = "deleteIssued", method = RequestMethod.GET)
	public String deleteIssued(Integer propIssuedID, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("propIssuedID===="+propIssuedID);
		PropagandaIssued propIss = propIssuedService.findById(propIssuedID);
		List<Patient> list = propIss.getPatients();
		System.out.println("dddddd===="+list.size());
		for (int i = 0; i < list.size(); i++) {
			Patient patient = list.get(i);
			patient.getPropissueds().remove(propIss);
			propIss.getPatients().remove(patient);
		}
		propIssuedService.delete(propIssuedID);
		return "redirect:/cdc/propIssuedList";
	}

	@RequestMapping(value = "updateIssued", method = RequestMethod.GET)
	public ModelAndView updateIssued(Integer propIssuedID, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PropagandaIssued propIssued = propIssuedService.findById(propIssuedID);
		List<BaseGeographic> geographics = baseGeographicService.getBasicsGeographicNodes();
		List<CdcOrganization> cdcOrgs = cdcOrganizationService.getAll();
		List<PropagandaDatum> propDatums = propDatumService.getAll();
		ModelMap map = new ModelMap();
		map.put("propIssued", propIssued);
		map.put("geographics", geographics);
		map.put("cdcOrgs", cdcOrgs);
		map.put("propDatums", propDatums);
		return new ModelAndView("cdc/updatePropIssued", map);
	}

	@RequestMapping(value = "updateIssued", method = RequestMethod.POST)
	public String updateIssued(PropagandaIssued propIssued, Address address, HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		String provience = baseGeographicService.getBaseGeographicByID(request.getParameter("provience")).getGeogDesignation();
		String city = baseGeographicService.getBaseGeographicByID(request.getParameter("city")).getGeogDesignation();
		String district = baseGeographicService.getBaseGeographicByID(request.getParameter("district")).getGeogDesignation();
		String street = baseGeographicService.getBaseGeographicByID(request.getParameter("street")).getGeogDesignation();
		address.setProvience(provience);
		address.setCity(city);
		address.setDistrict(district);
		address.setStreet(street);
		List<Patient> list = userService.getPatientByAddress(address,propIssued.getLanguage());
		if (list.size()>0 && !request.getParameter("datum").equals("-1")) {
			HttpSession session =  request.getSession();
			Cdc cdc = (Cdc)session.getAttribute("cdc");
			PropagandaDatum datum = null;
			if (request.getParameter("datum") != null && !request.getParameter("datum").equals("-1")) {
				datum = propDatumService.findById(Integer.parseInt(request.getParameter("datum")));
			}
			propIssued.setCdc(cdc);
			propIssued.setAddress(address);
			propIssued.setIssuedDate((new SimpleDateFormat("yyyy-MM-dd")).format(new Date()));
			propIssued.setPropDatum(datum);
			propIssued.setNotified(false);
			propIssued.setPatients(list);
			PropagandaIssued issued = propIssuedService.findById(propIssued.getPropIssuedID());
			BeanUtils.copyProperties(propIssued, issued);
			propIssuedService.update(issued);
			return "redirect:/cdc/propIssuedList";
		}else{
			return "redirect:/cdc/errNoctice";
		}
	}
}
