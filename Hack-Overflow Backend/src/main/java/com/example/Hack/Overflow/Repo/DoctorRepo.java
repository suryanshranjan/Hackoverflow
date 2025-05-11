package com.example.Hack.Overflow.Repo;

import com.example.Hack.Overflow.Model.Clinic;
import org.springframework.data.jpa.repository.JpaRepository;

public interface DoctorRepo extends JpaRepository<Clinic,Long> {
}
