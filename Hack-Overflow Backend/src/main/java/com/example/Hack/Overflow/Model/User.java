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
private String imageUrl;

    @Enumerated(EnumType.STRING)
    private USER_ROLE role;

private Address address;
    @PrePersist
    @PreUpdate
    public void setDefaultImage() {
        if (this.imageUrl == null || this.imageUrl.trim().isEmpty()) {
            this.imageUrl = "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_1280.png";
        }
    }
}