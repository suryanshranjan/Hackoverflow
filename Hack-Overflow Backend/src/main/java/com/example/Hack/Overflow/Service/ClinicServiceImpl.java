package com.example.Hack.Overflow.Service;

import com.example.Hack.Overflow.Model.Appointment;
import com.example.Hack.Overflow.Model.Clinic;
import com.example.Hack.Overflow.Model.TimeSlot;
import com.example.Hack.Overflow.Model.User;
import com.example.Hack.Overflow.Repo.Appointmentrepo;
import com.example.Hack.Overflow.Repo.ClinicRepository;
import com.example.Hack.Overflow.Repo.UserRepository;
import com.example.Hack.Overflow.config.JwtProvider;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;


@Service
public class ClinicServiceImpl  implements ClinicService{
    @Autowired
    private JwtProvider jwtProvider;
    @Autowired
    private UserRepository userrepo;
    @Autowired
    private ClinicRepository clinicrepo;
    @Autowired
    private Appointmentrepo appointrepo;
    @Override
    public List<TimeSlot> getAvailableTimeSlotsFromClinic(Long doctorId, LocalDate date, Duration slotLength)
    {
        User doctor = userrepo.findById(doctorId)
                .orElseThrow(() -> new RuntimeException("Doctor not found"));

        Clinic clinic = clinicrepo.findByDoctor(doctor);
        if(clinic==null){
            throw new RuntimeException("Doctor Not found");
        }
        // Build start and end datetime from clinic hours
        LocalDateTime startDateTime = LocalDateTime.of(date, LocalTime.parse(clinic.getOpening()));
        LocalDateTime endDateTime = LocalDateTime.of(date, LocalTime.parse(clinic.getClosing()));

        // Get all appointments for the day
        List<TimeSlot> busySlots = appointrepo.findByDoctor_IdAndStartTimeBetween(doctorId, startDateTime, endDateTime);
        busySlots.sort(Comparator.comparing(TimeSlot::getStartTime));

        List<TimeSlot> freeSlots = new ArrayList<>();
        LocalDateTime current = startDateTime;

        for (TimeSlot appt : busySlots) {
            while (current.plus(slotLength).isBefore(appt.getStartTime()) ||
                    current.plus(slotLength).isEqual(appt.getStartTime())) {
                freeSlots.add(new TimeSlot(current, current.plus(slotLength)));
                current = current.plus(slotLength);
            }

            if (appt.getEndTime().isAfter(current)) {
                current = appt.getEndTime();
            }
        }

        while (!current.plus(slotLength).isAfter(endDateTime)) {
            freeSlots.add(new TimeSlot(current, current.plus(slotLength)));
            current = current.plus(slotLength);
        }
        return freeSlots;
    }
    @Override
    public Clinic createCLinic(Clinic clinic,String jwt){
        System.out.println(jwt);
        String doctor = jwtProvider.getEmailFromJwtToken(jwt);
        System.out.println(doctor);
        User user=userrepo.findByEmail(doctor);
        System.out.println(user.getId());
        clinic.setDoctor(user);
        return clinicrepo.save(clinic);
    }
    public static double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
        final int R = 6371; // Earth radius in kilometers

        double latDistance = Math.toRadians(lat2 - lat1);
        double lonDistance = Math.toRadians(lon2 - lon1);
        double a = Math.sin(latDistance / 2) * Math.sin(latDistance / 2) +
                Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2)) *
                        Math.sin(lonDistance / 2) * Math.sin(lonDistance / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        double distance = R * c;
        System.out.println(distance);
        return distance;
    }

    // Method to find doctors (or clinics) within a given radius and sort them by distance
    @Override
    public List<Clinic> findNearestClinics(double latitude, double longitude, double radius) {
        // Fetch doctors from the database
        List<Clinic> clinic = clinicrepo.findAll();
System.out.println(clinic.get(0).getClinicName());
        System.out.println(clinic.get(0).getAddress().getLatitude());
        // Filter doctors by calculating their distance and sort them by distance
        List<Clinic> sortedDoctors =clinic.stream()
                .map(clinic1 -> {
                    double distance = calculateDistance(latitude, longitude, clinic1.getAddress().getLatitude(),clinic1.getAddress().getLongitude());
                    clinic1.setDistance(distance); // Set the distance to doctor (assuming User entity has this property)
                    return clinic1;
                })
                .filter(clinic1 -> clinic1.getDistance() <= radius) // Only include doctors within the radius
                .sorted(Comparator.comparingDouble(Clinic::getDistance)) // Sort doctors by distance
                .collect(Collectors.toList());
        for(int i=0;i<sortedDoctors.size();i++){
System.out.println(sortedDoctors.get(i).getClinicName());}
        return sortedDoctors; // Returns list of doctors (clinics) sorted by distance
    }
    @Override
    public List<Clinic> findAll(){
        return clinicrepo.findAll();
    }
    @Override
    public Clinic findByDoctorId(long id){
        return clinicrepo.getClinicByDoctorId(id);
    }
@Override
    public void removeIfAdressNull(){
       List<Clinic>ss= clinicrepo.findAll();
       for(Clinic s:ss){
           if(s.getAddress()==null){
              clinicrepo.deleteById(s.getId());
           }
       }

}
}
