package com.example.Hack.Overflow;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication@ComponentScan(basePackages = {
		"com.example.Hack.Overflow.Service",
		"com.example.Hack.Overflow.Controller",
		"com.example.Hack.Overflow.Repo",
		"com.example.Hack.Overflow.Model"
})
public class HackOverflowApplication {

	public static void main(String[] args) {

		SpringApplication.run(HackOverflowApplication.class, args);
	}

}
