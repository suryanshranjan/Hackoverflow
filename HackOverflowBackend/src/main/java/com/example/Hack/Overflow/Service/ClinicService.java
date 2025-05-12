package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Clinic;
import com.example.Hack.Overflow.Model.TimeSlot;

import java.time.Duration;
import java.time.LocalDate;
import java.util.List;

public interface ClinicService {
    public List<TimeSlot> getAvailableTimeSlotsFromClinic(Long doctorId, LocalDate date, Duration slotLength);
public Clinic createCLinic(Clinic clinic,String jwt);
public List<Clinic> findNearestClinics(double latitude, double longitude, double radius);

    List<Clinic> findAll();

    Clinic findByDoctorId(long id);
void removeIfAdressNull();
}
