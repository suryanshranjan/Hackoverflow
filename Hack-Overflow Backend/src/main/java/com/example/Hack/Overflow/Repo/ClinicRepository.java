package com.example.Hack.Overflow.Repo;

import com.example.Hack.Overflow.Model.Clinic;
import com.example.Hack.Overflow.Model.User;
import org.springframework.data.jpa.repository.JpaRepository;



public interface ClinicRepository extends JpaRepository<Clinic,Long> {
   public Clinic findByDoctor(User doctor);

   Clinic getClinicByDoctorId(long id);
}
