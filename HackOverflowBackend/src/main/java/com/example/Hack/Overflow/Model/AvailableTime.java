package com.example.Hack.Overflow.Model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.LocalDateTime;
@Data
@Entity
public class AvailableTime {

@Id
@GeneratedValue(strategy= GenerationType.AUTO)
    private Long Id;
private LocalDateTime startTime;
private LocalDateTime endTime;

@ManyToOne
private Clinic doctor;

}
