package com.example.Hack.Overflow.Request;

import lombok.Data;

import java.time.LocalDateTime;
@Data
public class AppointmentRequest {
    Long doctorId;
    Long patientId;
    public LocalDateTime startTime;
    public LocalDateTime EndTime;
}
