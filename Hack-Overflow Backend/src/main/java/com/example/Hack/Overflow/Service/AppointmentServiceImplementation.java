package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Appointment;
import org.springframework.stereotype.Service;

@Service
public class AppointmentServiceImplementation implements AppointmentService{

    @Override
    public String createAppointment(Appointment appointment) {
        return "";
    }

    @Override
    public String Cancel(Appointment appointment) {
        return "";
    }

    @Override
    public String getAppointmentByPatientandDoctor(Appointment appointment) {
        return "";
    }

    @Override
    public String getAppointmentByPatient(Long DoctorId) {
        return "";
    }

    @Override
    public String getAppointmentByDoctor(Long PatientId) {
        return "";
    }
}
