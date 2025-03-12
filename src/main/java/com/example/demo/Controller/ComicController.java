package com.example.demo.Controller;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.Models.Comic;
import com.example.demo.Models.Comment;
import com.example.demo.Models.Genre;
import com.example.demo.Models.Rental;
import com.example.demo.Models.User;
import com.example.demo.Services.ComicService;
import com.example.demo.Services.CommentService;
import com.example.demo.Services.GenreService;
import com.example.demo.Services.RentalService;
import com.example.demo.Services.UserService;



import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class ComicController {

	@Autowired
	UserService userService;

	@Autowired
	ComicService comicService;
	
	@Autowired
	CommentService commentService;
  
	@Autowired
	GenreService genreService;
	
	@Autowired
	RentalService rentalService;

	// Home Page
	@GetMapping("/home")
	public String homepage(HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		model.addAttribute("user", userService.getLoggedInUser(userId));
		// Fetch all comics
		List<Comic> comicList = comicService.allComics();
		model.addAttribute("comics", comicList);
		// Fetch IDs of currently rented comics
		List<Long> rentedComicIds = rentalService.findRentedComicIds();
		model.addAttribute("rentedComicIds", rentedComicIds);
		// Fetch comics rented by the logged-in user
		List<Rental> rentedComics = rentalService.findRentalsByUser(userId);
		model.addAttribute("rentedComics", rentedComics);
		return "homepage.jsp";
	}

	// Takes you to a form to create a new comic
	@GetMapping("/books/new")
	public String newComic(@ModelAttribute("comic") Comic comic, HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		model.addAttribute("genres", genreService.allGenres());
		if (userId == null) {
			return "redirect:/";
		}
		model.addAttribute("user", userService.getLoggedInUser(userId));
		return "newComic.jsp";
	}

	// Actually creates the new comic
	@PostMapping("/newBook")
    public String createComic(@Valid @ModelAttribute("comic") Comic comic, BindingResult result, @ModelAttribute("genres") Genre genre,
            @RequestParam("coverPicture") MultipartFile file, HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
        if (result.hasErrors()) {
        	model.addAttribute("user", userService.getLoggedInUser(userId));
        	model.addAttribute("genres", genreService.allGenres());
            return "newComic.jsp";
        }
        
        if (userId == null) {
            return "redirect:/";
        }
        
        String uploadDir = "uploads/cover_pictures/";
        Path uploadPath = Paths.get(uploadDir);
        
        try {
            // Create the directory if it doesn't exist
            if (!Files.exists(uploadPath)) {
                Files.createDirectories(uploadPath);
            }

            // Handle file upload
            if (!file.isEmpty()) {
                String fileName = file.getOriginalFilename();
                Path path = Paths.get(uploadDir + fileName);
                try {
                    // Save file to a directory
                    Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                    comic.setCoverImage(fileName); // Set path to comic entity
                } catch (IOException e) {
                    e.printStackTrace(); // Handle error, maybe show a message to the user
                }
            }
            comicService.createComic(comic);
            return "redirect:/home";
        } catch (IOException e) {
            e.printStackTrace();
            return "redirect:/books/new";
        }
    }
	
	//Shows you all the details of a comic
	@GetMapping("/books/details/{comicId}")
	public String showComicDetails(@PathVariable("comicId") Long comicId, @ModelAttribute("comment") Comment comment, HttpSession session, Model model) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}

		Comic comic = comicService.findComic(comicId);
		if (comic == null) {
			return "redirect:/books";
		}
		model.addAttribute("user", userService.getLoggedInUser(userId));
		model.addAttribute("comic", comic);
		model.addAttribute("userId", userId);
		
		List<Comment>comments = commentService.allComments();
		model.addAttribute("comments", comments);

		return "comicDetails.jsp";
	}
	
	// Takes you to update comic form where you can make changes
	@GetMapping("/books/edit/{id}")
	public String editComic(@PathVariable("id") Long id, Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		model.addAttribute("user", userService.getLoggedInUser(userId));
		Comic comic = comicService.findComic(id);
		model.addAttribute("comic", comic);
		model.addAttribute("genres", genreService.allGenres());
		return "editComic.jsp";
	}
	
	// Updates the Comic
	@PutMapping("/books/{id}")
	public String updateComic(@PathVariable("id") Long id, @Valid @ModelAttribute("comic") Comic comic,
	        BindingResult result, Model model, HttpSession session, @RequestParam("coverPicture") MultipartFile file) {
	    if (result.hasErrors()) {
	        model.addAttribute("comic", comic);
	        return "editComic.jsp";
	    }
	    Long userId = (Long) session.getAttribute("userId");
	    if (userId == null) {
	        return "redirect:/";
	    }

	    // Retrieve existing comic to retain the current cover image if no new file is uploaded
	    Comic existingComic = comicService.findComic(id);
	    if (existingComic == null) {
	        return "redirect:/home";
	    }

	    String uploadDir = "uploads/cover_pictures/";
	    Path uploadPath = Paths.get(uploadDir);

	    try {
	        // Create the directory if it doesn't exist
	        if (!Files.exists(uploadPath)) {
	            Files.createDirectories(uploadPath);
	        }

	        // Handle file upload if a new file is provided
	        if (!file.isEmpty()) {
	            String fileName = file.getOriginalFilename();
	            Path path = Paths.get(uploadDir + fileName);
	            try {
                    // Save file to a directory
                    Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
                    comic.setCoverImage(fileName); // Set new cover image path
                } catch (IOException e) {
                    e.printStackTrace(); // Handle error, maybe show a message to the user
                }
	        } else {
	            // Retain the existing cover image path
	            comic.setCoverImage(existingComic.getCoverImage());
	        }

	        comicService.updateComic(comic);
	        return "redirect:/home";
	    } catch (IOException e) {
	        e.printStackTrace();
	        return "redirect:/home";
	    }
	}
	
	// Rent a comic
	@PostMapping("/books/rent/{comicId}")
	public String rentComic(@PathVariable("comicId") Long comicId, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
	    if (userId == null) {
	        return "redirect:/";
	    }
	    
	    User user = userService.getLoggedInUser(userId);
	    Comic comic = comicService.findComic(comicId);
	    
	    if(comic != null && user != null) {
	    	Rental rental = new Rental();
	    	rental.setUser(user);
	    	rental.setComic(comic);
	    	rentalService.createRental(rental);
	    }
	    return "redirect:/home";
	}
	
	// Return a comic
	@PostMapping("/books/return/{rentalId}")
	public String returnComic(@PathVariable("rentalId") Long rentalId, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
	    if (userId == null) {
	        return "redirect:/";
	    }
	    
	    Rental rental = rentalService.findRentalById(rentalId);
	    if (rental != null && rental.getUser().getId().equals(userId)) {
	    	rentalService.deleteRental(rentalId);
	    }
	    return "redirect:/home";
	}
	//search for comics by title
	@GetMapping("/books/search")
	public String searchPage(Model model, HttpSession session) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		model.addAttribute("user", userService.getLoggedInUser(userId));
		return "comicSearch.jsp";
	}
	//return searched comics
	@GetMapping("/books/results")
	public String searchBar(Model model, HttpSession session, @RequestParam("search") String search) {
		Long userId = (Long) session.getAttribute("userId");
		if (userId == null) {
			return "redirect:/";
		}
		model.addAttribute("user", userService.getLoggedInUser(userId));
		
		if (search != null && search.length() > 0) {
			model.addAttribute("searchedComics", comicService.findByTitle(search));
		}
		return "comicSearch.jsp";
	}


	// Delete a comic by id
	@DeleteMapping("/books/destroy/{id}")
	public String destroyComic(@PathVariable("id") Long id) {
		comicService.deleteComic(id);
		return "redirect:/home";
	}
	
}

