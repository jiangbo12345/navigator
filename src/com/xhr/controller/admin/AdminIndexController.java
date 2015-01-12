package com.xhr.controller.admin;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.multipart.MultipartFile;

import com.xhr.entity.BaseGeographic;
import com.xhr.entity.BaseStation;
import com.xhr.entity.CdcOrganization;
import com.xhr.entity.Hospital;
import com.xhr.entity.PropagandaDatum;
import com.xhr.entity.user.Address;
import com.xhr.entity.user.Cdc;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.Role;
import com.xhr.entity.user.User;
import com.xhr.service.IBaseGeographicService;
import com.xhr.service.IBaseStationService;
import com.xhr.service.ICdcOrganizationService;
import com.xhr.service.IHospitalService;
import com.xhr.service.IPropagandaDatumService;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("/admin")
public class AdminIndexController {

	private static final Logger LOG = Logger.getLogger(AdminIndexController.class);
	@Autowired
	IUserService userService;

	@Autowired
	IPropagandaDatumService propDatumService;

	@Autowired
	IBaseGeographicService baseGeographicService;

	@Autowired
	IBaseStationService baseStationService;

	@Autowired
	IHospitalService hospitalService;

	@Autowired
	ICdcOrganizationService cdcOrganizationService;

	@RequestMapping(value = "index", method = RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("admin/index", null);
	}

	@RequestMapping(value = "cdcOrgList", method = RequestMethod.GET)
	public ModelAndView cdcOrgList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<CdcOrganization> list = cdcOrganizationService.getAll();
		ModelMap map = new ModelMap();
		map.put("list", list);
		return new ModelAndView("admin/cdcOrgList", map);
	}

	@RequestMapping(value = "addCdcOrg", method = RequestMethod.GET)
	public ModelAndView addCdcOrg(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<BaseGeographic> geographics = baseGeographicService.getBasicsGeographicNodes();
		ModelMap map = new ModelMap();
		map.put("geographics", geographics);
		return new ModelAndView("admin/addCdcOrg", map);
	}

	@RequestMapping(value = "addCdcOrg", method = RequestMethod.POST)
	public String addCdcOrg(CdcOrganization cdcOrg, Address address, HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		String provience = baseGeographicService.getBaseGeographicByID(address.getProvience()).getGeogDesignation();
		String city = baseGeographicService.getBaseGeographicByID(address.getCity()).getGeogDesignation();
		String district = baseGeographicService.getBaseGeographicByID(address.getDistrict()).getGeogDesignation();
		System.out.println("district=======" + district);
		address.setProvience(provience);
		address.setCity(city);
		address.setDistrict(district);
		cdcOrg.setAddress(address);
		cdcOrganizationService.save(cdcOrg);
		return "redirect:/admin/cdcOrgList";
	}

	@RequestMapping(value = "updateCdcOrg", method = RequestMethod.GET)
	public ModelAndView updatecdcOrg(Integer id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		CdcOrganization cdcOrg = cdcOrganizationService.findById(id);
		List<BaseGeographic> geographics = baseGeographicService.getBasicsGeographicNodes();
		ModelMap map = new ModelMap();
		map.put("cdcOrg", cdcOrg);
		map.put("geographics", geographics);
		return new ModelAndView("admin/updateCdcOrg", map);
	}

	@RequestMapping(value = "saveCdcOrg", method = RequestMethod.POST)
	public String saveCdcOrg(CdcOrganization cdcOrg, Address address, HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		String provience = baseGeographicService.getBaseGeographicByID(address.getProvience()).getGeogDesignation();
		String city = baseGeographicService.getBaseGeographicByID(address.getCity()).getGeogDesignation();
		String district = baseGeographicService.getBaseGeographicByID(address.getDistrict()).getGeogDesignation();
		address.setProvience(provience);
		address.setCity(city);
		address.setDistrict(district);
		CdcOrganization bs = cdcOrganizationService.findById(cdcOrg.getId());
		List<BaseGeographic> geographics = baseGeographicService.getBasicsGeographicNodes();
		cdcOrg.setAddress(address);
		BeanUtils.copyProperties(cdcOrg, bs);
		CdcOrganization upcdcOrg = cdcOrganizationService.update(bs);
		ModelMap map = new ModelMap();
		map.put("cdcOrg", upcdcOrg);
		map.put("geographics", geographics);
		return "redirect:/admin/cdcOrgList";
	}

	@RequestMapping(value = "deleteCdcOrg", method = RequestMethod.GET)
	public String deleteCdcOrg(Integer id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		cdcOrganizationService.delete(id);
		return "redirect:/admin/cdcOrgList";
	}

	@RequestMapping(value = "hospitalList", method = RequestMethod.GET)
	public ModelAndView hospitalList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<Hospital> list = hospitalService.getAll();
		ModelMap map = new ModelMap();
		map.put("list", list);
		return new ModelAndView("admin/hospitalList", map);
	}

	@RequestMapping(value = "addHospital", method = RequestMethod.GET)
	public ModelAndView addHospital(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<CdcOrganization> list = cdcOrganizationService.getAll();
		List<BaseGeographic> geographics = baseGeographicService.getBasicsGeographicNodes();
		ModelMap map = new ModelMap();
		map.put("list", list);
		map.put("geographics", geographics);
		return new ModelAndView("admin/addHospital", map);
	}

	@RequestMapping(value = "addHospital", method = RequestMethod.POST)
	public String addHospital(Hospital hospital, Address address, HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		String provience = baseGeographicService.getBaseGeographicByID(address.getProvience()).getGeogDesignation();
		String city = baseGeographicService.getBaseGeographicByID(address.getCity()).getGeogDesignation();
		String district = baseGeographicService.getBaseGeographicByID(address.getDistrict()).getGeogDesignation();
		String street = baseGeographicService.getBaseGeographicByID(address.getStreet()).getGeogDesignation();
		address.setStreet(street);
		address.setProvience(provience);
		address.setCity(city);
		address.setDistrict(district);
		System.out.println("hospital.getHospitalDesignation()==="+hospital.getHospitalDesignation());
		String cdcOrgId = request.getParameter("cdcOrgID");
		System.out.println("cdcOrgId==============" + cdcOrgId);
		CdcOrganization cdcOrg = cdcOrganizationService.getCdcOrgByID(Integer.parseInt(cdcOrgId));
		hospital.setAddress(address);
		hospital.setCdcOrganization(cdcOrg);
		hospitalService.save(hospital);
		return "redirect:/admin/hospitalList";
	}

	@RequestMapping(value = "updateHospital", method = RequestMethod.GET)
	public ModelAndView updateHospital(Integer id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Hospital hospital = hospitalService.findById(id);
		List<CdcOrganization> list = cdcOrganizationService.getAll();
		List<BaseGeographic> geographics = baseGeographicService.getBasicsGeographicNodes();
		ModelMap map = new ModelMap();
		map.put("hospital", hospital);
		map.put("list", list);
		map.put("geographics", geographics);
		return new ModelAndView("admin/updateHospital", map);
	}

	@RequestMapping(value = "saveHospital", method = RequestMethod.POST)
	public String saveHospital(Hospital hospital, Address address, HttpServletRequest request, HttpServletResponse response) throws ServletException,
			IOException {
		Hospital bs = hospitalService.findById(hospital.getId());
		String provience = baseGeographicService.getBaseGeographicByID(address.getProvience()).getGeogDesignation();
		String city = baseGeographicService.getBaseGeographicByID(address.getCity()).getGeogDesignation();
		String district = baseGeographicService.getBaseGeographicByID(address.getDistrict()).getGeogDesignation();
		String street = baseGeographicService.getBaseGeographicByID(address.getStreet()).getGeogDesignation();
		address.setStreet(street);
		address.setProvience(provience);
		address.setCity(city);
		address.setDistrict(district);
		String cdcOrgId = request.getParameter("cdcOrgID");
		CdcOrganization cdcOrg = cdcOrganizationService.getCdcOrgByID(Integer.parseInt(cdcOrgId));
		hospital.setCdcOrganization(cdcOrg);
		hospital.setAddress(address);
		BeanUtils.copyProperties(hospital, bs);
		Hospital upHospital = hospitalService.update(bs);
		ModelMap map = new ModelMap();
		map.put("hospital", upHospital);
		return "redirect:/admin/hospitalList";
	}

	@RequestMapping(value = "deleteHospital", method = RequestMethod.GET)
	public String deleteHospital(Integer id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		hospitalService.delete(id);
		return "redirect:/admin/hospitalList";
	}

	@RequestMapping(value = "basestationlist", method = RequestMethod.GET)
	public ModelAndView basestationlist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<BaseStation> list = baseStationService.getAll();
		ModelMap map = new ModelMap();
		map.put("list", list);
		return new ModelAndView("admin/baseStationList", map);
	}

	@RequestMapping(value = "addBaseStation", method = RequestMethod.GET)
	public ModelAndView addBaseStation(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return new ModelAndView("admin/addBaseStation", null);
	}

	@RequestMapping(value = "addBaseStation", method = RequestMethod.POST)
	public String addbs(BaseStation baseStation, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		baseStationService.save(baseStation);
		return "redirect:/admin/basestationlist";
	}

	@RequestMapping(value = "updateBaseStation", method = RequestMethod.GET)
	public ModelAndView updateBaseStation(Integer id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BaseStation baseStation = baseStationService.findById(id);
		ModelMap map = new ModelMap();
		map.put("baseStation", baseStation);
		return new ModelAndView("admin/updateBaseStation", map);
	}

	@RequestMapping(value = "saveBaseStation", method = RequestMethod.POST)
	public String saveBaseStation(BaseStation baseStation, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		BaseStation bs = baseStationService.findById(baseStation.getId());
		BeanUtils.copyProperties(baseStation, bs);
		BaseStation upBaseStaion = baseStationService.update(bs);
		ModelMap map = new ModelMap();
		map.put("baseStation", upBaseStaion);
		return "redirect:/admin/updateBaseStation";
	}

	@RequestMapping(value = "deleteBaseStation", method = RequestMethod.GET)
	public String deleteBaseStation(Integer id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		baseStationService.delete(id);
		return "redirect:/admin/basestationlist";
	}

	@RequestMapping(value = "basegeographiclist", method = RequestMethod.GET)
	public ModelAndView basicsgeographiclist(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LOG.info("basicsgeographiclist==================");
		List<BaseGeographic> list = baseGeographicService.getBasicsGeographicNodes();
		ModelMap map = new ModelMap();
		map.put("list", list);
		return new ModelAndView("admin/basgeoglist", map);
	}

	@RequestMapping(value = "addbasegeographic", method = RequestMethod.GET)
	public ModelAndView addBasicsGeographic(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		LOG.info("addBasicsGeographic==================");
		List<BaseGeographic> list = baseGeographicService.getBasicsGeographicNodes();
		ModelMap map = new ModelMap();
		map.put("list", list);
		return new ModelAndView("admin/addBasicsGeographic", map);
	}

	@RequestMapping(value = "savebasgeog", method = RequestMethod.POST)
	public String savebasgeog(Address address, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		manageProvience(address, request);
		return "redirect:/admin/basegeographiclist";
	}

	private void manageStreet(Address address, BaseGeographic bgDistrict, HttpServletRequest request) {
		BaseGeographic bgStreet = null;
		if (bgDistrict != null) {
			if (!address.getStreet().equals("") && !address.getStreet().equals(request.getParameter("streetText"))) {
				bgStreet = baseGeographicService.getBaseGeographicByID(address.getStreet());
				String district = bgStreet.getGeogDesignation();
				if (district != null && !district.equals("")) {
					if (!request.getParameter("streetText").equals("") && !district.equals(request.getParameter("streetText"))) {
						bgStreet.setGeogDesignation(request.getParameter("streetText"));
						baseGeographicService.update(bgStreet);
					}
				} else {
					bgStreet = null;
				}
			} else {
				if (!request.getParameter("streetText").equals("")) {
					bgStreet = new BaseGeographic();
					bgStreet.setGeogDesignation(request.getParameter("streetText"));
					bgStreet.setNodeRank(4);
					bgStreet.setParentNode(bgDistrict.getId());
					baseGeographicService.save(bgStreet);
				}
			}
		}
	}

	private void manageDistrict(Address address, BaseGeographic bgCity, HttpServletRequest request) {
		BaseGeographic bgDistrict = null;
		if (bgCity != null) {
			if (!address.getDistrict().equals("") && !address.getDistrict().equals(request.getParameter("districtText"))) {
				bgDistrict = baseGeographicService.getBaseGeographicByID(address.getDistrict());
				String district = bgDistrict.getGeogDesignation();
				if (district != null && !district.equals("")) {
					if (!request.getParameter("districtText").equals("") && !district.equals(request.getParameter("districtText"))) {
						bgDistrict.setGeogDesignation(request.getParameter("districtText"));
						baseGeographicService.update(bgDistrict);
					}
				} else {
					bgDistrict = null;
				}
			} else {
				if (!request.getParameter("districtText").equals("")) {
					bgDistrict = new BaseGeographic();
					bgDistrict.setGeogDesignation(request.getParameter("districtText"));
					bgDistrict.setNodeRank(3);
					bgDistrict.setParentNode(bgCity.getId());
					baseGeographicService.save(bgDistrict);
				}
			}
		}
		manageStreet(address, bgDistrict, request);
	}

	private void manageCity(Address address, BaseGeographic bgProvience, HttpServletRequest request) {
		BaseGeographic bgCity = null;
		if (bgProvience != null) {
			if (!address.getCity().equals("") && !address.getCity().equals(request.getParameter("cityText"))) {
				bgCity = baseGeographicService.getBaseGeographicByID(address.getCity());
				String city = bgCity.getGeogDesignation();
				if (city != null && !city.equals("")) {
					if (!request.getParameter("cityText").equals("") && !city.equals(request.getParameter("cityText"))) {
						bgCity.setGeogDesignation(request.getParameter("cityText"));
						baseGeographicService.update(bgCity);
					}
				} else {
					bgCity = null;
				}
			} else {
				if (!request.getParameter("cityText").equals("")) {
					bgCity = new BaseGeographic();
					bgCity.setGeogDesignation(request.getParameter("cityText"));
					bgCity.setNodeRank(2);
					bgCity.setParentNode(bgProvience.getId());
					baseGeographicService.save(bgCity);
				}
			}
		}
		manageDistrict(address, bgCity, request);
	}

	private void manageProvience(Address address, HttpServletRequest request) {
		BaseGeographic bgProvience = null;
		if (!address.getProvience().equals("") && !address.getProvience().equals(request.getParameter("provienceText"))) {
			bgProvience = baseGeographicService.getBaseGeographicByID(address.getProvience());
			String provience = bgProvience.getGeogDesignation();
			if (provience != null && !provience.equals("")) {
				if (!request.getParameter("provienceText").equals("") && !provience.equals(request.getParameter("provienceText"))) {
					bgProvience.setGeogDesignation(request.getParameter("provienceText"));
					baseGeographicService.update(bgProvience);
				}
			} else {
				bgProvience = null;
			}
		} else {
			if (!request.getParameter("provienceText").equals("")) {
				bgProvience = new BaseGeographic();
				bgProvience.setGeogDesignation(request.getParameter("provienceText"));
				bgProvience.setNodeRank(1);
				bgProvience.setParentNode(2);
				baseGeographicService.save(bgProvience);
			}
		}
		manageCity(address, bgProvience, request);
	}

	@RequestMapping(value = "deleteGeog", method = RequestMethod.POST)
	public String deleteGeog(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int street = Integer.parseInt(request.getParameter("streetText"));
		if (street > 0) {
			baseGeographicService.delete(street);
		} else {
			int district = Integer.parseInt(request.getParameter("districtText"));
			if (district > 0) {
				deleteDistrict(district);
			} else {
				int city = Integer.parseInt(request.getParameter("cityText"));
				if (city > 0) {
					deleteCity(city);
				} else {
					int provience = Integer.parseInt(request.getParameter("provienceText"));
					if (provience > 0) {
						deleteProvience(provience);
					}
				}
			}
		}
		return "redirect:/admin/basegeographiclist";
	}

	private void deleteProvience(int provience) {
		List<BaseGeographic> cityList = baseGeographicService.getParentByID(provience);
		if (cityList.size() > 0) {
			for (BaseGeographic bgCity : cityList) {
				deleteCity(bgCity.getId());
			}
		}
		baseGeographicService.delete(provience);
	}

	private void deleteCity(int city) {
		List<BaseGeographic> districtList = baseGeographicService.getParentByID(city);
		if (districtList.size() > 0) {
			for (BaseGeographic bgDistrict : districtList) {
				deleteDistrict(bgDistrict.getId());
			}
		}
		baseGeographicService.delete(city);
	}

	private void deleteDistrict(int district) {
		List<BaseGeographic> streetList = baseGeographicService.getParentByID(district);
		if (streetList.size() > 0) {
			for (BaseGeographic bgStreet : streetList) {
				baseGeographicService.delete(bgStreet.getId());
			}
		}
		baseGeographicService.delete(district);
	}

	@RequestMapping(value = "update", method = RequestMethod.POST)
	public String update(Address address, Patient pa, Doctor doc, Cdc c, HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		User user = userService.getUserByID(Integer.parseInt(request.getParameter("id")));
		if (user.getRole() == Role.PATIENT) {
			Patient patient = (Patient) user;
			pa.setAddress(address);
			if (pa.getPassword().equals("")) {
				pa.setPassword(patient.getPassword());
			}
			pa.setDoctors(patient.getDoctors());
			BeanUtils.copyProperties(pa, patient);
			userService.update(patient);
			return "redirect:/admin/patientList";
		} else if (user.getRole() == Role.DOCTOR) {
			Doctor doctor = (Doctor) user;
			doc.setAddress(address);
			if (!doctor.getPhone().equals(doc.getPhone())) {
				doctor.setSynced(0);
			}
			Hospital hospital = null;
			if (request.getParameter("hospitalName") != null || !request.getParameter("hospitalName").equals("")) {
				System.out.println("request.getParameter(hospitalName)====="+request.getParameter("hospitalName"));
				hospital = hospitalService.findById(Integer.parseInt(request.getParameter("hospitalName")));
			}
			doc.setHospital(hospital);
			if (doc.getPassword().equals("")) {
				doc.setPassword(doctor.getPassword());
			}
			doc.setPatients(doctor.getPatients());
			BeanUtils.copyProperties(doc, doctor);
			 userService.update(doctor);
			return "redirect:/admin/doctorList";
		} else if (user.getRole() == Role.CDC) {
			Cdc cdc = (Cdc) user;
			CdcOrganization cdcOrg = null;
			if (request.getParameter("org") != null || !request.getParameter("org").equals("")) {
				System.out.println("request.getParameter(cdcOrg)====="+request.getParameter("org"));
				cdcOrg = cdcOrganizationService.findById(Integer.parseInt(request.getParameter("org")));
			}
			c.setAddress(address);
			c.setCdcOrg(cdcOrg);
			if (c.getPassword().equals("")) {
				c.setPassword(cdc.getPassword());
			}
			BeanUtils.copyProperties(c, cdc);
			userService.update(cdc);
			return "redirect:/admin/cdcList";
		}
		return "redirect:/admin/index";
	}

	@RequestMapping(value = "propDatumList", method = RequestMethod.GET)
	public ModelAndView propDatumList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<PropagandaDatum> list = propDatumService.getAll();
		ModelMap map = new ModelMap();
		map.put("list", list);
		return new ModelAndView("admin/propagandaDatum", map);
	}

	@RequestMapping(value = "addDatum", method = RequestMethod.GET)
	public ModelAndView addDatum(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<CdcOrganization> list = cdcOrganizationService.getAll();
		ModelMap map = new ModelMap();
		map.put("list", list);
		return new ModelAndView("admin/addPropDatum", map);
	}

	@RequestMapping(value = "addPropDatum", method = RequestMethod.POST)
	public String addPropDatum(@RequestParam("fileMp3") MultipartFile fileMp3, PropagandaDatum propDatum, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String fileName = fileMp3.getOriginalFilename();
		if (!fileName.equals("") || fileName.length() > 0) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String suffix = fileName.substring(fileName.lastIndexOf("."));
			String pathDir = "/content/static/propDatum/";
			String logoRealPathDir = request.getSession().getServletContext().getRealPath(pathDir);
			File file1 = new File(logoRealPathDir);
			if (!file1.exists())
				file1.mkdirs();
			String name = sdf.format(new Date()) + suffix;
			File file2 = new File(logoRealPathDir, name);
			if (file2.getParentFile() == null)
				file2.mkdirs();
			fileMp3.transferTo(file2);
			propDatum.setDatum(pathDir + name);
			CdcOrganization cdc = null;
			if (request.getParameter("organID") != null) {
				cdc = cdcOrganizationService.findById(Integer.parseInt(request.getParameter("organID")));
			}
			propDatum.setOrgan(cdc);
			propDatum.setUploadDate((new SimpleDateFormat("yyyy-MM-dd")).format(new Date()));
			propDatum.setDatumName(fileName);
			propDatumService.save(propDatum);
		}
		return "redirect:/admin/propDatumList";
	}

	@RequestMapping(value = "updateDatum", method = RequestMethod.GET)
	public ModelAndView updateDatum(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String propDatumID = request.getParameter("propDatumID");
		PropagandaDatum propDatum = propDatumService.findById(Integer.parseInt(propDatumID));
		List<CdcOrganization> list = cdcOrganizationService.getAll();
		ModelMap map = new ModelMap();
		map.put("list", list);
		map.put("propDatum", propDatum);
		return new ModelAndView("admin/updatePropDatum", map);
	}

	@RequestMapping(value = "updatePropDatum", method = RequestMethod.POST)
	public String updatePropDatum(@RequestParam("fileMp3") MultipartFile fileMp3, PropagandaDatum propDatum, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String propDatumID = request.getParameter("propDatumID");
		PropagandaDatum datum = propDatumService.findById(Integer.parseInt(propDatumID));
		String fileName = fileMp3.getOriginalFilename();
		if (!fileName.equals("") || fileName.length() > 0) {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String suffix = fileName.substring(fileName.lastIndexOf("."));
			String pathDir = "/content/static/propDatum/";
			String logoRealPathDir = request.getSession().getServletContext().getRealPath(pathDir);
			File file1 = new File(logoRealPathDir);
			if (!file1.exists())
				file1.mkdirs();
			String name = sdf.format(new Date()) + suffix;
			File file2 = new File(logoRealPathDir, name);
			if (file2.getParentFile() == null)
				file2.mkdirs();
			fileMp3.transferTo(file2);
			propDatum.setDatum(pathDir + name);
			propDatum.setDatumName(fileName);
		} else {
			propDatum.setDatum(datum.getDatum());
		}
		CdcOrganization cdc = cdcOrganizationService.findById(Integer.parseInt(request.getParameter("organID")));
		propDatum.setOrgan(cdc);
		propDatum.setUploadDate((new SimpleDateFormat("yyyy-MM-dd")).format(new Date()));
		BeanUtils.copyProperties(propDatum, datum);
		propDatumService.update(datum);
		return "redirect:/admin/propDatumList";
	}

	@RequestMapping(value = "deleteDatum", method = RequestMethod.GET)
	public String deleteDatum(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String propDatumID = request.getParameter("propDatumID");
		propDatumService.delete(Integer.parseInt(propDatumID));
		return "redirect:/admin/propDatumList";
	}

}
