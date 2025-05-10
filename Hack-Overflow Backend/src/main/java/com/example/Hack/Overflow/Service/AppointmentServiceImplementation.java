package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Appointment;
import com.example.Hack.Overflow.Model.User;
import com.example.Hack.Overflow.Repo.Appointmentrepo;
import com.example.Hack.Overflow.Repo.UserRepository;
import com.example.Hack.Overflow.Request.AppointmentRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class AppointmentServiceImplementation implements AppointmentService{
@Autowired
private Appointmentrepo appointrepo;
@Autowired
private UserRepository userrepo;


    @Override
    public Appointment createAppointment(AppointmentRequest appointment) {
        Optional<User> patient=userrepo.findById(appointment.getPatientId());
        Optional<User> doct=userrepo.findById(appointment.getDoctorId());
    Appointment appoint=new Appointment();
    appoint.setPatient(patient.get());
    appoint.setDoctor(doct.get());
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
        List<Appointment>ss=appointrepo.findByPatientIdAndDoctorId(patientId,DoctorId);
        return ss;
    }


    @Override
    public List<Appointment> getAppointmentByPatient(Long DoctorId) {

List<Appointment>ss=appointrepo.findByPatientId(DoctorId);
        return ss;
    }

    @Override
    public List<Appointment> getAppointmentByDoctor(Long PatientId) {
        List<Appointment>ss=appointrepo.findByDoctorId(PatientId);
   return ss;
    }
}
