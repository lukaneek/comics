package com.example.demo.Controller;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.demo.Models.LoggedInUser;
import com.example.demo.Models.User;
import com.example.demo.Services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;


@Controller
public class UserController {

	@Value("${app.url.path}")
	String appUrlPath;
	
    @Autowired
    UserService users;
    
    @GetMapping("/")
    public String hello() {
    	return "index.jsp";
    }
    // Login page
    @GetMapping("/login")
    public String login(Model model) {
        model.addAttribute("newLogin", new LoggedInUser());
        return "login.jsp";
    }
    
    @GetMapping("/register")
    public String register(Model model) {
        model.addAttribute("newUser", new User());
        return "register.jsp";
    }

    // checks if you are already registered with email, if not registers you
    @PostMapping("/register")
    public String registerUser(@Valid @ModelAttribute("newUser") User newUser, BindingResult result, HttpSession session, Model model) {
        users.register(newUser, result);
        if (result.hasErrors()) {
            model.addAttribute("newLogin", new LoggedInUser());
            return "register.jsp";
        } else {
            session.setAttribute("userId", newUser.getId());
            return "redirect:" + appUrlPath + "/home";
        }
    }

    // checks if you have an account and logs you in
    @PostMapping("/login")
    public String loginUser(@Valid @ModelAttribute("newLogin") LoggedInUser newLogin, BindingResult result, HttpSession session, Model model) {
        User user = users.login(newLogin, result);
        if (result.hasErrors()) {
            model.addAttribute("newUser", new User());
            return "login.jsp";
        } else {
            session.setAttribute("userId", user.getId());
            return "redirect:" + appUrlPath + "/home";
        }
    }
    
    @PostMapping("/guest")
    public String guest(@ModelAttribute("newLogin") LoggedInUser newLogin, BindingResult result, HttpSession session) {
    	UUID uuid = UUID.randomUUID();
    	User user = new User();
    	user.setFirstName("Guest");
    	user.setLastName("Guest");
    	user.setPassword("guest");
    	user.setConfirm("guest");
    	user.setEmail(uuid + "@guest.com");
    	user.setIsAdmin(true);
    	user = users.register(user, result);
    	session.setAttribute("userId", user.getId());
        return "redirect:" + appUrlPath + "/home";
    }

    // Logout the User
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:" + appUrlPath + "/login";
    }
}






