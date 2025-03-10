package com.example.demo.Services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Models.Genre;
import com.example.demo.Repositories.GenreRepository;

@Service
public class GenreService {
	
	@Autowired
	private GenreRepository genreRepo;
	
	public List<Genre> allGenres() {
		return genreRepo.findAll();
	}
	
	public Genre createGenre(Genre genre) {
		return genreRepo.save(genre);
	}
	
	public void deleteGenre(Long id) {
		genreRepo.deleteById(id);
	}
}

