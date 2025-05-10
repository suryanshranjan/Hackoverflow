package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Doctor;
import com.example.Hack.Overflow.Model.Patient;

import java.util.List;

public interface DoctorService {

    Doctor createDoctor(Doctor doctor);
    Doctor status(Long doctorId);
    Doctor deleteDoctor(Doctor doctor);
List<Patient> getPatientByDoctorId(Long DoctorId);

}
