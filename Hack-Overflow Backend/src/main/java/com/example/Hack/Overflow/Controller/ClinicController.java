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

import static org.springframework.http.ResponseEntity.ok;

@RestController
@RequestMapping("/api/Doctor/clinic")
public class ClinicController {

    @Autowired
    private ClinicService clinicService;


    @PostMapping("/create")
    public ResponseEntity<Clinic> createClinic(@RequestBody Clinic clinic,
                                               @RequestHeader("Authorization") String jwtToken) {
        System.out.println(jwtToken);
        Clinic created = clinicService.createCLinic(clinic, jwtToken); // Remove "Bearer "
        return ok(created);
    }


    @GetMapping("/{doctorId}/slots")
    public ResponseEntity<List<TimeSlot>> getAvailableSlots(@PathVariable Long doctorId,
                                                            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate date,
                                                            @RequestParam int slotMinutes) {
        List<TimeSlot> slots = clinicService.getAvailableTimeSlotsFromClinic(doctorId, date, Duration.ofMinutes(slotMinutes));
        System.out.println(slots.get(0).getStartTime());
        return ok(slots);
    }
    @GetMapping("/getnearest/{latitude}/{longitude}/{radius}")
    public ResponseEntity<List<Clinic>> getnearest(@PathVariable double latitude,@PathVariable double longitude,@PathVariable double radius){
        List<Clinic>ss=clinicService.findNearestClinics(latitude,longitude,radius);
        return ok(ss);
    }
    @GetMapping("/findall")
    public ResponseEntity<List<Clinic>> findallClinic(){
        List<Clinic>ss=clinicService.findAll();
        System.out.println(ss.get(0).getClinicName());
        return ok(ss);
    }
    @GetMapping("/doctorId/{id}")
    public Clinic findClinicByDoctor(@PathVariable long id)
    {
        Clinic clinic=clinicService.findByDoctorId(id);
        return clinic;

    }
@DeleteMapping("/delete")
    public void remove(){
        clinicService.removeIfAdressNull();
}
}
