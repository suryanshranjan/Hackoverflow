package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Clinic;
import com.example.Hack.Overflow.Model.Patient;

import java.util.List;

public interface DoctorService {

    Clinic createDoctor(Clinic doctor);
    Clinic status(Long doctorId);
    Clinic deleteDoctor(Clinic doctor);
List<Patient> getPatientByDoctorId(Long DoctorId);

}
