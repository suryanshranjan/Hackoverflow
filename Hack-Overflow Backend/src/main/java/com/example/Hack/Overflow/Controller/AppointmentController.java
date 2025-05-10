package com.example.Hack.Overflow.Controller;

import com.example.Hack.Overflow.Model.Appointment;
import com.example.Hack.Overflow.Request.AppointmentRequest;
import com.example.Hack.Overflow.Service.AppointmentService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/appointments")
public class AppointmentController {

    private final AppointmentService appointmentService;

    // Constructor Injection (recommended)
    public AppointmentController(AppointmentService appointmentService) {
        this.appointmentService = appointmentService;
    }

    @PostMapping("/create")
    public ResponseEntity<Appointment> create(@RequestBody AppointmentRequest appointment) {
        return ResponseEntity.ok(appointmentService.createAppointment(appointment));
    }
}
