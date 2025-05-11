package com.example.Hack.Overflow.Model;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.Duration;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
public class Clinic {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long Id;
    private String ClinicName;
    private String Email;
    private String Speciality;
    private String Opening;
    private String Closing;
    private Double Distance;
    private Duration slotLength;
    @ManyToOne
    private User doctor;
    @Embedded
    private Address address;
}

