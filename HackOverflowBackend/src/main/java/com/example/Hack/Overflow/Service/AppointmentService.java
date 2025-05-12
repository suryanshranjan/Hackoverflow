package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Appointment;
import com.example.Hack.Overflow.Request.AppointmentRequest;

import java.time.LocalDateTime;
import java.util.List;

public interface AppointmentService{

    Appointment createAppointment(AppointmentRequest appointment);
  void Cancel(Long id);
    List<Appointment> getAppointmentByPatientandDoctor(Long patientId,Long DoctorId);

    List<Appointment> getAppointmentByPatient(Long PatientId);
    List<Appointment> getAppointmentByDoctor(Long DoctorId);
  List<Appointment> getPendingAppointment();
  List<Appointment> CompletedAppointment();
  void CompleteThisAppointment(Appointment appoint);

  Appointment getById(long id);
}
