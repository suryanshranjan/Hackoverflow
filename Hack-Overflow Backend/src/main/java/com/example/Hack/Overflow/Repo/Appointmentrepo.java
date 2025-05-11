package com.example.Hack.Overflow.Repo;

import com.example.Hack.Overflow.Model.Appointment;
import com.example.Hack.Overflow.Model.TimeSlot;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface Appointmentrepo extends JpaRepository<Appointment,Long> {
    List<Appointment> findByPatient_Id(Long doctorId);
    List<Appointment> findByDoctor_Id(Long doctorId);


    List<Appointment> findByPatient_IdAndDoctor_Id(Long patientId, Long doctorId);
    @Query("SELECT new com.example.Hack.Overflow.Model.TimeSlot(a.startTime, a.endTime) " +
            "FROM Appointment a WHERE a.doctor.id = :doctorId AND a.startTime BETWEEN :start AND :end")
    List<TimeSlot> findByDoctor_IdAndStartTimeBetween(@Param("doctorId") Long doctorId,
                                                      @Param("start") LocalDateTime start,
                                                      @Param("end") LocalDateTime end);

}
