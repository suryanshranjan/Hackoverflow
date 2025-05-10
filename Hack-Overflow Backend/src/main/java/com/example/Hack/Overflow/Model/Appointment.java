package com.example.Hack.Overflow.Model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
@Data
@Entity
public class Appointment {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @ManyToOne
    private User doctor;
    @ManyToOne
    private User patient;

    private LocalDateTime startTime;
    private LocalDateTime EndTime;
    private boolean Status;


}
