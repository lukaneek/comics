package com.example.demo.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.example.demo.Models.Genre;
import com.example.demo.Services.GenreService;
import com.example.demo.Services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class GenreController {
	
	@Value("${app.url.path}")
	String appUrlPath;
	
	@Autowired
	private GenreService genreServ;
	@Autowired
	private UserService userService;
	
	@GetMapping("/genres")
	public String all(Model model, @ModelAttribute("genre") Genre genre, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:" + appUrlPath + "/";
		}
		model.addAttribute("user", userService.getLoggedInUser(userId));
		model.addAttribute("genres", genreServ.allGenres());
		
		return "genre.jsp";
	}
	
	@PostMapping("/genres")
	public String create(@Valid @ModelAttribute("genre") Genre genre, BindingResult result, HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:" + appUrlPath + "/";
		}
		if (result.hasErrors()) {
			model.addAttribute("user", userService.getLoggedInUser(userId));
			model.addAttribute("genres", genreServ.allGenres());
			return "genre.jsp";
		}
		else {
			genreServ.createGenre(genre);
			return "redirect:" + appUrlPath + "/genres";
		}
	}
	
	@DeleteMapping("/genres/{id}")
	public String destroy(@PathVariable("id") Long id) {
		genreServ.deleteGenre(id);
		return "redirect:" + appUrlPath + "/genres";
	}
}

