package com.example.Hack.Overflow.Controller;

import com.example.Hack.Overflow.Model.Appointment;
import com.example.Hack.Overflow.Model.TimeSlot;
import com.example.Hack.Overflow.Request.AppointmentRequest;
import com.example.Hack.Overflow.Service.AppointmentServiceImplementation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/appointments")
public class AppointmentController {

    @Autowired
    private AppointmentServiceImplementation appointmentService;


    @PostMapping("/create")
    public ResponseEntity<Appointment> createAppointment(@RequestBody AppointmentRequest appointmentRequest) {
        try {
            Appointment appointment = appointmentService.createAppointment(appointmentRequest);
            return new ResponseEntity<>(appointment, HttpStatus.CREATED);
        } catch (RuntimeException e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }
    }


    @DeleteMapping("/cancel/{id}")
    public ResponseEntity<Void> cancelAppointment(@PathVariable Long id) {
        appointmentService.Cancel(id);
        return new ResponseEntity<>(HttpStatus.NO_CONTENT);
    }


    @GetMapping("/patient/{patientId}/doctor/{doctorId}")
    public ResponseEntity<List<Appointment>> getAppointmentsByPatientAndDoctor(@PathVariable Long patientId, @PathVariable Long doctorId) {
        List<Appointment> appointments = appointmentService.getAppointmentByPatientandDoctor(patientId, doctorId);
        return new ResponseEntity<>(appointments, HttpStatus.OK);
    }


    @GetMapping("/patient/{patientId}")
    public ResponseEntity<List<Appointment>> getAppointmentsByPatient(@PathVariable Long patientId) {
        List<Appointment> appointments = appointmentService.getAppointmentByPatient(patientId);
        return new ResponseEntity<>(appointments, HttpStatus.OK);
    }


    @GetMapping("/doctor/{doctorId}")
    public ResponseEntity<List<Appointment>> getAppointmentsByDoctor(@PathVariable Long doctorId) {
        List<Appointment> appointments = appointmentService.getAppointmentByDoctor(doctorId);
        return new ResponseEntity<>(appointments, HttpStatus.OK);
    }


    @GetMapping("/doctor/{doctorId}/conflicts")
    public ResponseEntity<List<TimeSlot>> getDoctorConflicts(@PathVariable Long doctorId,
                                                                @RequestParam("start") String start,
                                                                @RequestParam("end") String end) {

        try {
            LocalDateTime startTime = LocalDateTime.parse(start);
            LocalDateTime endTime = LocalDateTime.parse(end);
            List<TimeSlot> conflictingAppointments = appointmentService.findDoctorConflicts(doctorId, startTime, endTime);
            return new ResponseEntity<>(conflictingAppointments, HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>(null, HttpStatus.BAD_REQUEST);
        }

    }

    @GetMapping("/pending")
    public ResponseEntity<List<Appointment>> getPendingAppointments() {
        return ResponseEntity.ok(appointmentService.getPendingAppointment());
    }


    @GetMapping("/completed")
    public ResponseEntity<List<Appointment>> getCompletedAppointments() {
        return ResponseEntity.ok(appointmentService.CompletedAppointment());
    }


    @PostMapping("/complete/{id}")
    public void completeAppointment(@PathVariable long id) {
        Appointment appointment=appointmentService.getById(id);
        appointmentService.CompleteThisAppointment(appointment);
    }

}
