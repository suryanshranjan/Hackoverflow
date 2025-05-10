package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Doctor;
import com.example.Hack.Overflow.Model.Patient;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class DoctorServiceImpl implements DoctorService{
    @Override
    public Doctor createDoctor(Doctor doctor) {
        return null;
    }

    @Override
    public Doctor status(Long doctorId) {
        return null;
    }

    @Override
    public Doctor deleteDoctor(Doctor doctor) {
        return null;
    }

    @Override
    public List<Patient> getPatientByDoctorId(Long DoctorId) {
        return List.of();
    }
}
