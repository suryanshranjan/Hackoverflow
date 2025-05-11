package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Appointment;
import com.example.Hack.Overflow.Model.TimeSlot;
import com.example.Hack.Overflow.Model.User;
import com.example.Hack.Overflow.Repo.Appointmentrepo;
import com.example.Hack.Overflow.Repo.UserRepository;
import com.example.Hack.Overflow.Request.AppointmentRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
@Transactional
@Service
public class AppointmentServiceImplementation implements AppointmentService {
    @Autowired
    private Appointmentrepo appointrepo;
    @Autowired
    private UserRepository userrepo;

    @Override
    public Appointment createAppointment(AppointmentRequest appointment) {

        Optional<User> patient = userrepo.findById(appointment.getPatientId());
        Optional<User> doctor = userrepo.findById(appointment.getDoctorId());

        if (patient.isEmpty()) {
            throw new RuntimeException("Patient not found with ID: " + appointment.getPatientId());
        }
        if (doctor.isEmpty()) {
            throw new RuntimeException("Doctor not found with ID: " + appointment.getDoctorId());
        }

        Appointment appoint = new Appointment();
        appoint.setPatient(patient.get());
        appoint.setDoctor(doctor.get());
        appoint.setEndTime(appointment.getEndTime());
        appoint.setStartTime(appointment.getStartTime());
        appoint.setStatus(true);
        appointrepo.save(appoint);

        return appoint;
    }


    @Override
    public void Cancel(Long id) {

        appointrepo.deleteById(id);
    }

    @Override
    public List<Appointment> getAppointmentByPatientandDoctor(Long patientId, Long DoctorId) {
        List<Appointment> ss = appointrepo.findByPatient_IdAndDoctor_Id(patientId, DoctorId);
        return ss;
    }


    @Override
    public List<Appointment> getAppointmentByPatient(Long DoctorId) {

        List<Appointment> ss = appointrepo.findByPatient_Id(DoctorId);
        return ss;
    }

    @Override
    public List<Appointment> getAppointmentByDoctor(Long PatientId) {
        List<Appointment> ss = appointrepo.findByDoctor_Id(PatientId);
        return ss;
    }

  @Override
    public List<Appointment> getPendingAppointment() {
        List<Appointment> ss = appointrepo.findAll();
        List<Appointment> pendng = new ArrayList<>();
        for (Appointment s : ss) {
            if (s.isStatus()) {
                pendng.add(s);
            }
        }
        return pendng;
    }

   @Override
    public void CompleteThisAppointment(Appointment appoint) {
        appoint.setStatus(!appoint.isStatus());
        appointrepo.save(appoint);
    }

    @Override
    public Appointment getById(long id) {
        Optional<Appointment> appoint= appointrepo.findById(id);
        if(appoint.get()!=null){
            return appoint.get();
        }
        return null;
    }


  @Override
    public List<Appointment> CompletedAppointment() {

        List<Appointment> ss = appointrepo.findAll();
        List<Appointment> completed = new ArrayList<>();
        for (Appointment s : ss) {
            System.out.println(s.isStatus());
            if (!s.isStatus()) {
                completed.add(s);
            }
        }
        return completed;
    }

    public List<TimeSlot> findDoctorConflicts(Long doctorId, LocalDateTime newStart, LocalDateTime newEnd) {

        return appointrepo.findByDoctor_IdAndStartTimeBetween(doctorId, newStart, newEnd);
    }

}