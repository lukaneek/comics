package com.example.demo.Repositories;


import java.util.List;
import java.util.Optional;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.Models.Genre;

@Repository
public interface GenreRepository extends CrudRepository<Genre, Long>{
	List<Genre> findAll();
	
	Optional<Genre> findById(Long id);
}