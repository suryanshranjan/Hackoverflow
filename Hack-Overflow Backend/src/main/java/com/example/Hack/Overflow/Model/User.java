package com.example.Hack.Overflow.Model;

import com.example.Hack.Overflow.Model.Address;
import com.example.Hack.Overflow.Model.Doctor;
import com.example.Hack.Overflow.Model.Patient;
import com.example.Hack.Overflow.Model.USER_ROLE;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;



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
private String speciality;
private Address address;

}