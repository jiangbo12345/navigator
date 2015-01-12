
package com.xhr.controller.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.xhr.entity.user.Patient;
import com.xhr.entity.user.Role;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("/admin")
public class AdminPatientController {

    private static final Logger LOG = Logger.getLogger(AdminPatientController.class);

    @Autowired
    IUserService userService;

    @RequestMapping(value = "patientsImport", method = RequestMethod.GET)
    public ModelAndView patientsImportPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("admin/patientsImport", null);
    }

    @RequestMapping(value = "patientsImport", method = RequestMethod.POST)
    public ModelAndView patientsImport(@RequestParam("file")
    MultipartFile file, HttpServletRequest request, HttpServletResponse response) throws Exception {
        parseFile(file);
        ModelMap map = new ModelMap();
        map.put("message", "上传成功");
        return new ModelAndView("admin/patientsImport", map);
    }

    private void parseFile(MultipartFile multipartFile) throws Exception {
        String fileName = multipartFile.getOriginalFilename().toLowerCase();
        if (fileName.endsWith("xls")) {
            LOG.debug("==== deal the xls file ");
            HSSFWorkbook webwork = new HSSFWorkbook(multipartFile.getInputStream());
            dealWorkbook(webwork);
        } else if (fileName.endsWith("xlsx")) {
            LOG.debug("==== deal the xlsx file ");
            Workbook webwork = new XSSFWorkbook(multipartFile.getInputStream());
            dealWorkbook(webwork);
        }
    }

    private void dealWorkbook(Workbook webwork) {
        try {
            Sheet sheet = webwork.getSheetAt(0);
            int firstCellNum;
            String sex = "";
            for (int i = sheet.getFirstRowNum() + 1; i <= sheet.getLastRowNum(); i++) {
                Row row = sheet.getRow(i);
                firstCellNum = row.getFirstCellNum();
                Patient patient = new Patient();
                patient.setUserName(row.getCell(firstCellNum).getStringCellValue());
                patient.setPhone(row.getCell(firstCellNum + 1).getStringCellValue());
                patient.setIdentifier(row.getCell(firstCellNum + 2).getStringCellValue());
                patient.setBirthDay(row.getCell(firstCellNum + 3).getStringCellValue());
                patient.setRegistrationDate(row.getCell(firstCellNum + 4).getStringCellValue());
                patient.setFirstTakeDate(row.getCell(firstCellNum + 5).getStringCellValue());
                sex = row.getCell(firstCellNum + 6).getStringCellValue();
                sex = sex.equals("女") ? "F" : "M";
                patient.setSex(sex);
                patient.setNation(row.getCell(firstCellNum + 7).getStringCellValue());
                patient.setLoginName(patient.getIdentifier());
                patient.setPassword(patient.getIdentifier());
                patient.setRole(Role.PATIENT);
                userService.regist(patient);
            }
            LOG.debug("last row = " + sheet.getLastRowNum());
        } catch (Exception e) {
            LOG.error(e);
        }
    }
}
