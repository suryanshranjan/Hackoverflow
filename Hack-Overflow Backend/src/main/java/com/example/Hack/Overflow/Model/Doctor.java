package com.example.Hack.Overflow.Model;

import jakarta.persistence.Embedded;
import jakarta.persistence.Entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Doctor {
    private String FullName;
    private String Email;
    private String Password;
    private String Speciality;
    @Embedded
    private Address address;
}

