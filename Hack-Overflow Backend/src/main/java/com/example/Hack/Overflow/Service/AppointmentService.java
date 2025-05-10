package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Appointment;

public interface AppointmentService{

    String createAppointment(Appointment appointment);
    String Cancel(Appointment appointment);
    String getAppointmentByPatientandDoctor(Appointment appointment);

    String getAppointmentByPatient(Long DoctorId);
    String getAppointmentByDoctor(Long PatientId);

}
