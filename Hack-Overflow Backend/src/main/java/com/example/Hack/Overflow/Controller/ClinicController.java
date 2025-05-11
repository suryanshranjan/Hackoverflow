package com.example.Hack.Overflow.Controller;

import com.example.Hack.Overflow.Model.Clinic;
import com.example.Hack.Overflow.Model.TimeSlot;
import com.example.Hack.Overflow.Service.ClinicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.Duration;
import java.time.LocalDate;
import java.util.List;

@RestController
@RequestMapping("/api/clinic")
public class ClinicController {

    @Autowired
    private ClinicService clinicService;


    @PostMapping("/create")
    public ResponseEntity<Clinic> createClinic(@RequestBody Clinic clinic,
                                               @RequestHeader("Authorization") String jwtToken) {
        Clinic created = clinicService.createCLinic(clinic, jwtToken.substring(7)); // Remove "Bearer "
        return ResponseEntity.ok(created);
    }


    @GetMapping("/{doctorId}/slots")
    public ResponseEntity<List<TimeSlot>> getAvailableSlots(@PathVariable Long doctorId,
                                                            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
                                                            @RequestParam int slotMinutes) {
        List<TimeSlot> slots = clinicService.getAvailableTimeSlotsFromClinic(doctorId, date, Duration.ofMinutes(slotMinutes));
        System.out.println(slots.get(0).getStartTime());
        return ResponseEntity.ok(slots);
    }
}
