package com.example.Hack.Overflow.Controller;

import com.example.Hack.Overflow.Model.User;
import com.example.Hack.Overflow.Repo.UserRepository;
import com.example.Hack.Overflow.Request.LoginRequest;
import com.example.Hack.Overflow.Response.AuthResponse;
import com.example.Hack.Overflow.Service.CustomeUserServiceImplementation;
import com.example.Hack.Overflow.config.JwtProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;


import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.util.List;

@RestController
@RequestMapping("/auth")
public class AuthController
{    private final UserRepository userRepository;
    private final CustomeUserServiceImplementation customUserDetails;
    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final JwtProvider jwtProvider;
    public AuthController(
            UserRepository userRepository,
    CustomeUserServiceImplementation customUserDetails,
    PasswordEncoder passwordEncoder,
    AuthenticationManager authenticationManager,
    JwtProvider jwtProvider
    ) {
        this.userRepository = userRepository;
        this.customUserDetails = customUserDetails;
        this.passwordEncoder = passwordEncoder;
        this.authenticationManager = authenticationManager;
        this.jwtProvider = jwtProvider;
    }
    @PostMapping("/signup")
    public ResponseEntity<AuthResponse> register(@RequestBody User user) {
        if (userRepository.findByEmail(user.getEmail()) != null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(null);
        }

        user.setPassword(passwordEncoder.encode(user.getPassword()));
        User saved = userRepository.save(user);

        Authentication auth = new UsernamePasswordAuthenticationToken(user.getEmail(), user.getPassword(), List.of(() -> user.getRole().name()));
        SecurityContextHolder.getContext().setAuthentication(auth);
        String token = jwtProvider.generateToken(auth);

        AuthResponse response = new AuthResponse();
        response.setJwt(token);
        response.setMessage("Register Success");
        response.setRole(saved.getRole());
        response.setUserId(saved.getId());

        return ResponseEntity.ok(response);
    }

    @PostMapping("/signin")
    public ResponseEntity<AuthResponse> signin(@RequestBody LoginRequest login) {
        try {
            Authentication auth = authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(login.getEmail(), login.getPassword())
            );

            SecurityContextHolder.getContext().setAuthentication(auth);
            String token = jwtProvider.generateToken(auth);

            User user = (User) userRepository.findByEmail(login.getEmail());

            AuthResponse response = new AuthResponse();
            response.setJwt(token);
            response.setMessage("Login Success");
            response.setUserId(user.getId());
            response.setRole(user.getRole());
            return ResponseEntity.ok(response);

        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
        }
    }

    private Authentication authenticate(String username, String password) {
        UserDetails userDetails = customUserDetails.loadUserByUsername(username);

        System.out.println("sign in userDetails - " + userDetails);

        if (userDetails == null) {
            System.out.println("sign in userDetails - null " + userDetails);
            throw new BadCredentialsException("Invalid username or password");
        }
        if (!passwordEncoder.matches(password, userDetails.getPassword())) {
            System.out.println("sign in userDetails - password not match " + userDetails);
            throw new BadCredentialsException("Invalid username or password");
        }
        return new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
    }
}
