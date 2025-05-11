package com.example.Hack.Overflow.Repo;


import com.example.Hack.Overflow.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User,Long> {
public User save(User user);
   public User findByEmail(String email);


   }
