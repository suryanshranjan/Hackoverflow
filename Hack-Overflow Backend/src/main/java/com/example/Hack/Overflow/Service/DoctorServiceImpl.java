package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Clinic;
import com.example.Hack.Overflow.Model.Patient;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DoctorServiceImpl implements DoctorService{
    @Override
    public Clinic createDoctor(Clinic doctor) {
        return null;
    }

    @Override
    public Clinic status(Long doctorId) {
        return null;
    }

    @Override
    public Clinic deleteDoctor(Clinic doctor) {
        return null;
    }

    @Override
    public List<Patient> getPatientByDoctorId(Long DoctorId) {
        return List.of();
    }
}
