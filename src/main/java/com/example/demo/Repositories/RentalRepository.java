package com.example.demo.Repositories;


import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.Models.Rental;

@Repository
public interface RentalRepository extends CrudRepository<Rental, Long> {

	List<Rental> findByUserId(Long userId);
	
	@Query("SELECT r.comic.id FROM Rental r")
	List<Long> findCurrentlyRentedComicIds();
}
