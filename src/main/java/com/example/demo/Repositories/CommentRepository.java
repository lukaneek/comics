package com.example.demo.Repositories;


import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.Models.Comment;





@Repository
public interface CommentRepository extends CrudRepository<Comment, Long>{
    // this method retrieves all the comments from the database
	List<Comment> findAll();
}
