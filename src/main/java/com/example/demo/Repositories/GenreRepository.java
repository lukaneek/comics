package com.example.demo.Repositories;


import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.Models.Genre;

@Repository
public interface GenreRepository extends CrudRepository<Genre, Long>{
	List<Genre> findAll();
}