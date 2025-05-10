package com.example.Hack.Overflow.Repo;

import com.example.Hack.Overflow.Model.Appointment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface Appointmentrepo extends JpaRepository<Appointment,Long> {
    List<Appointment> findByPatientId(Long doctorId);
    List<Appointment> findByDoctorId(Long doctorId);

    List<Appointment> findByPatientIdAndDoctorId(Long patientId, Long doctorId);
}
