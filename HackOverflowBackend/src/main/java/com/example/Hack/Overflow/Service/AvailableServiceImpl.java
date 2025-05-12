//package com.example.Hack.Overflow.Service;
//
//import com.example.Hack.Overflow.Model.AvailableTime;
//import com.example.Hack.Overflow.Model.TimeSlot;
//import com.example.Hack.Overflow.Repo.AvailableRepo;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.time.LocalDateTime;
//import java.util.ArrayList;
//import java.util.List;
//@Service
//public class AvailableServiceImpl implements AvailabilityService{
//    @Autowired
//    private AvailableRepo availablerepo;
//    @Override
//    public List<TimeSlot> MatchingSlot(long DoctorID, LocalDateTime startTime, LocalDateTime endTime) {
//        List<AvailableTime>ss=availablerepo.getMatchingSlot(DoctorID,startTime,endTime);
//        List<TimeSlot>timeslot=new ArrayList<>();
//        for(AvailableTime av:ss){
//            timeslot.add(new TimeSlot(av.getStartTime(),av.getEndTime()));
//        }
//        return timeslot;
//    }
//
//    @Override
//    public List<TimeSlot> allBookedSlot(long DoctorId) {
//        return availablerepo.findAllBookedSlotsByDoctorId(DoctorId);
//    }
//    @Override
//    public List<TimeSlot> getFreeTimeSlot(long doctorId){
//        List<TimeSlot>ss=new ArrayList<>();
//
//        return ss;
//    }
//}
