package com.example.Hack.Overflow.Model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class TimeSlot {
    LocalDateTime startTime;
    LocalDateTime endTime;


}
