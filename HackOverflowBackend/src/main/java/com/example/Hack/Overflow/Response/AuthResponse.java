package com.example.Hack.Overflow.Response;

import com.example.Hack.Overflow.Model.USER_ROLE;
import jakarta.persistence.Entity;
import lombok.Data;

@Data
public class AuthResponse {
    private String message;
    private String jwt;
    private USER_ROLE role;
    private Long userId;
}
