package com.example.demo.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.example.demo.Models.Comic;
import com.example.demo.Models.Comment;
import com.example.demo.Models.User;
import com.example.demo.Services.ComicService;
import com.example.demo.Services.CommentService;
import com.example.demo.Services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class CommentController {

	@Value("${app.url.path}")
	String appUrlPath;
	
	@Autowired
	CommentService comments;

	@Autowired
	UserService users;
	
	@Autowired
	ComicService comics;

	// Create a new Comment
	@PostMapping("/comments/{comicId}")
	public String createComment(@Valid @ModelAttribute("comment") Comment comment, BindingResult result,
			HttpSession session, @PathVariable("comicId") Long comicId, Model model, RedirectAttributes redirectAttributes) {
		Comic oneComic = comics.findComic(comicId);
		if (result.hasErrors()) {
			model.addAttribute("comic", oneComic);
			return "comicDetails.jsp";
		}
		
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:" + appUrlPath + "/";
		}
		
		
		User loggedInUser = users.getLoggedInUser(userId);
		
		List<Comment> commentList = oneComic.getComment();
		commentList.add(comment);
		
		comment.setComic(oneComic);
		comment.setUser(loggedInUser);
		comments.createComment(comment);
		return "redirect:" + appUrlPath + "/home";
	}

	// Delete a comment by id
	@DeleteMapping("/comments/destroy/{id}")
	public String destroyComment(@PathVariable("id") Long id) {
		comments.deleteComment(id);
		return "redirect:" + appUrlPath + "/home";
	}
}