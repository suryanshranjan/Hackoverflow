//package com.example.Hack.Overflow.Repo;
//
//import com.example.Hack.Overflow.Model.AvailableTime;
//import com.example.Hack.Overflow.Model.TimeSlot;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.data.jpa.repository.Query;
//
//import java.time.LocalDateTime;
//import java.util.List;
//
//public interface AvailableRepo extends JpaRepository<AvailableTime,Long> {
//    @Query("""
//SELECT a FROM Appointment a
//WHERE a.doctor.id = :doctorID
//AND a.startTime >= :from
//AND a.endTime <= :to
//ORDER BY a.startTime
//""")
//    List<AvailableTime> getMatchingSlot(long doctorID, LocalDateTime from, LocalDateTime to);
//
//
//    List<TimeSlot> findAllBookedSlotsByDoctorId(long doctorId);
//}
