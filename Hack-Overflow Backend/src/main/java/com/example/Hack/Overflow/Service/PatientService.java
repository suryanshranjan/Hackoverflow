package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Patient;
import com.example.Hack.Overflow.Model.Patient;

import java.util.List;

public interface PatientService {

 Patient createPatient(Patient Patient);
 Patient deletePatient(Patient Patient);
 List<Patient> getPatientByPatientId(Long PatientId);
}
