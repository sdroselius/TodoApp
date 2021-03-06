package com.skilldistillery.todoapp.controllers;

import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.skilldistillery.todoapp.entities.Todo;
import com.skilldistillery.todoapp.services.TodoService;

@CrossOrigin({"*", "http://localhost:4201"})
@RequestMapping("api")
@RestController
public class TodoController {

	@Autowired
	private TodoService todoSvc;

	private String username = "shaun";

	@GetMapping("todos")
	public Set<Todo> index(HttpServletRequest req, HttpServletResponse res) {
		return todoSvc.index(username);
	}

	@GetMapping("todos/{tid}")
	public Todo show(HttpServletRequest req, HttpServletResponse res, @PathVariable int tid) {
		Todo todo = todoSvc.show(username, tid);
		if (todo == null) {
			res.setStatus(404);
		}
		return todo;
	}

	@PostMapping("todos")
	public Todo create(HttpServletRequest req, HttpServletResponse res, @RequestBody Todo todo) {
		try {
			todo = todoSvc.create(username, todo);
			if (todo != null) {
				res.setStatus(201);
				StringBuffer url = req.getRequestURL();
				url.append("/").append(todo.getId());
				res.setHeader("Location", url.toString());
			} else {
				res.setStatus(401);
			}
		} catch (Exception e) {
			res.setStatus(400);
			todo = null;
		}
		return todo;

	}

	@PutMapping("todos/{tid}")
	public Todo update(HttpServletRequest req, HttpServletResponse res, 
			@PathVariable int tid, @RequestBody Todo todo) {
		try {
			todo = todoSvc.update(username, tid, todo);
			if (todo == null) {
				res.setStatus(404);
			}
		} catch (Exception e) {
			res.setStatus(400);
		}
		return todo;

	}

	@DeleteMapping("todos/{tid}")
	public void destroy(HttpServletRequest req, HttpServletResponse res, 
			@PathVariable int tid) {
		try {
			if (todoSvc.destroy(username, tid)) {
				res.setStatus(204);
			}
			else {
				res.setStatus(404);
			}
		} catch (Exception e) {
			res.setStatus(400);
		}

	}

}
