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
public class Patient {
private String FullName;
    private String Email;
    private String Password;
@Embedded
    private String Address;

}
