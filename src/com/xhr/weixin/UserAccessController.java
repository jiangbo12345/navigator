
package com.xhr.weixin;

import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.http.HttpResponse;
import org.apache.http.client.CookieStore;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpRequestBase;
import org.apache.http.client.protocol.HttpClientContext;
import org.apache.http.impl.client.BasicCookieStore;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.protocol.BasicHttpContext;
import org.apache.http.protocol.HttpContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.xhr.entity.user.Admin;
import com.xhr.entity.user.Cdc;
import com.xhr.entity.user.Doctor;
import com.xhr.entity.user.Patient;
import com.xhr.entity.user.Role;
import com.xhr.entity.user.User;
import com.xhr.service.IUserService;

@Controller
@RequestMapping("/weixin")
public class UserAccessController {

    @Autowired
    IUserService userService;

    @RequestMapping(value = "index", method = RequestMethod.GET)
    public String index(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String name = null;//getFromCookies(request);
        System.out.println("========name from cookies===========" + name);
        if (name == null) {
            String uuid = request.getParameter("uuid");
            System.out.println("========uuid===========" + uuid);
            if (uuid == null || uuid.isEmpty()) {
                uuid = Long.toString(UUID.randomUUID().getMostSignificantBits());
                return "redirect:http://nav.hi-ray.com/getUser?uuid=" + uuid;
            } else {
                name = request.getParameter("name");
                System.out.println("========name from request===========" + name);
            }
        }
        Doctor doctor = (Doctor) userService.getUser(name);
        HttpSession session = request.getSession();
        session.setAttribute("doctor", doctor);
        session.setAttribute("loginUser", doctor);
        return "redirect:/doctor/index";
    }

    protected String getContent(HttpRequestBase request) throws Exception {
        CookieStore cookieStore = new BasicCookieStore();
        HttpContext context = new BasicHttpContext();
        context.setAttribute(HttpClientContext.COOKIE_STORE, cookieStore);
        HttpClient client = HttpClientBuilder.create().build();
        HttpResponse response = client.execute(request, context);
        InputStream inputStream = response.getEntity().getContent();
        StringWriter writer = new StringWriter();
        IOUtils.copy(inputStream, writer, "GBK");
        String content = writer.toString();
        System.out.println(content);
        return content;
    }

    private String getFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            System.out.println("========cookies size===========" + cookies.length);
            for (Cookie ck : cookies) {
                System.out.println(ck.getName() + "========cookies name===========" + ck.getValue());
                if ("navigate.loginUser".equals(ck.getName())) {
                    return ck.getValue();
                }
            }
        }
        return null;
    }

    @RequestMapping(value = "wlogin", method = RequestMethod.GET)
    public ModelAndView loginPage(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        return new ModelAndView("weixin/login", null);
    }

    @RequestMapping(value = "wlogin", method = RequestMethod.POST)
    public String login(RedirectAttributes redirectAttributes, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String pwd = request.getParameter("password");
        User user = userService.getUser(name);
        if (user == null) {
            request.getSession().setAttribute("message", "nouser");
            return "redirect:/weixin/wlogin";
        } else {
            request.getSession().removeAttribute("message");
            if (user.getPassword().equals(pwd.trim())) {
                if (user.getRole() == Role.ADMIN) {
                    Admin admin = (Admin) user;
                    HttpSession session = request.getSession();
                    session.setAttribute("admin", admin);
                    session.setAttribute("loginUser", admin);
                    return "redirect:/admin/index";
                } else if (user.getRole() == Role.PATIENT) {
                    Patient patient = (Patient) user;
                    HttpSession session = request.getSession();
                    session.setAttribute("patient", patient);
                    session.setAttribute("loginUser", patient);
                    return "redirect:/patient/index";
                } else if (user.getRole() == Role.DOCTOR) {
                    Doctor doctor = (Doctor) user;
                    HttpSession session = request.getSession();
                    session.setAttribute("doctor", doctor);
                    session.setAttribute("loginUser", doctor);
                    Cookie cookie = new Cookie("navigate.loginUser", name);
                    cookie.setMaxAge(Integer.MAX_VALUE);
                    response.addCookie(cookie);
                    return "redirect:/doctor/index";
                } else if (user.getRole() == Role.CDC) {
                    Cdc cdc = (Cdc) user;
                    HttpSession session = request.getSession();
                    session.setAttribute("cdc", cdc);
                    session.setAttribute("loginUser", cdc);
                    return "redirect:/cdc/index";
                } else {
                    return "redirect:/weixin/wlogin";
                }
            } else {
                System.out.println("密码错误！！");
                request.getSession().setAttribute("message", "nouser");
                return "redirect:/weixin/wlogin";
            }

        }
    }
}
