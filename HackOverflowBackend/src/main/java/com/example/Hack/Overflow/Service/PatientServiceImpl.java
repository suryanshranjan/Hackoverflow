package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Patient;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class PatientServiceImpl implements PatientService {

    @Override
    public Patient createPatient(Patient Patient) {
        return null;
    }

    @Override
    public Patient deletePatient(Patient Patient) {
        return null;
    }

    @Override
    public List<Patient> getPatientByPatientId(Long PatientId) {
        return List.of();
    }
}
