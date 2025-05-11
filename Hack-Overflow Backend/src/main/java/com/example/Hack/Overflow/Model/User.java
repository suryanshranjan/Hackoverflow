package com.example.Hack.Overflow.Model;

import jakarta.persistence.*;
import lombok.Data;


@Data
@Entity
public class User {
    @Id
    @GeneratedValue
    private Long id;

    private String email;
    private String password;
    private String fullName;

    @Enumerated(EnumType.STRING)
    private USER_ROLE role;

private Address address;

}