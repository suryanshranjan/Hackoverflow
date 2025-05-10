package com.example.Hack.Overflow.Model;

import jakarta.persistence.*;

import java.time.LocalDateTime;

@Entity
public class AvailableTime {

@Id
@GeneratedValue(strategy= GenerationType.AUTO)
    private Long Id;
private LocalDateTime startTime;
private LocalDateTime endTime;

@ManyToOne
private Doctor doctor;

}
