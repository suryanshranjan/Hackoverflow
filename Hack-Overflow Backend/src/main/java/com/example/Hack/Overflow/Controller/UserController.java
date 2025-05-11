package com.example.Hack.Overflow.Controller;
import java.util.List;
import java.util.Optional;

import com.example.Hack.Overflow.Model.User;
import com.example.Hack.Overflow.Repo.UserRepository;
import com.example.Hack.Overflow.config.JwtProvider;
import jdk.jshell.spi.ExecutionControl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/users")
public class UserController {
   @Autowired
   private UserRepository userrepo;
   @Autowired
   private JwtProvider jwtprovider;
@GetMapping("/profile")
    public ResponseEntity<User> getUserProfileHandler(@RequestHeader("Authorization") String jwt) throws ExecutionControl.UserException {
        String email = jwtprovider.getEmailFromJwtToken(jwt);
        User user=userrepo.findByEmail(email);
        user.setPassword(null);
        return new ResponseEntity<>(user, HttpStatus.ACCEPTED);
    }
    @GetMapping("/profilew")
    public ResponseEntity<List<User>> getAllUser(@RequestHeader("Authorization") String jwt) throws ExecutionControl.UserException {

        List<User>user=userrepo.findAll();

        return new ResponseEntity<>(user, HttpStatus.ACCEPTED);
    }
    @GetMapping("/profile/{id}")
    public ResponseEntity<User> getUserProfileHandler(@PathVariable("id") Long id) throws ExecutionControl.UserException {

        Optional<User> user=userrepo.findById(id);
        user.get().setPassword(null);
        return new ResponseEntity<>(user.get(), HttpStatus.ACCEPTED);
    }

}
