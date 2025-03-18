package com.example.demo.Services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.Models.Comic;
import com.example.demo.Models.Genre;
import com.example.demo.Repositories.ComicRepository;
import com.example.demo.Repositories.GenreRepository;

@Service
public class GenreService {
	
	@Autowired
	private GenreRepository genreRepo;
	
	@Autowired
	private ComicRepository comicRepo;
	
	public List<Genre> allGenres() {
		return genreRepo.findAll();
	}
	
	public Genre createGenre(Genre genre) {
		return genreRepo.save(genre);
	}
	
	public Boolean deleteGenre(Long id) {
		Optional<Genre> optionalGenre = genreRepo.findById(id);
		if (optionalGenre.isPresent()) {
			Genre genre = optionalGenre.get();
			List<Comic> comics = comicRepo.findComicByGenres(genre);
			if (comics.size() == 0) {
				genreRepo.deleteById(id);
				return true;
			}
		}
		else {
			return true;
		}
		return false;
	}
}

