package com.example.demo.Repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.Models.Comic;

@Repository
public interface ComicRepository extends CrudRepository<Comic, Long> {
	// this method retrieves all the comics from the database
	List<Comic> findAll();
	
	List<Comic> findComicByTitleContaining(String title);
}
