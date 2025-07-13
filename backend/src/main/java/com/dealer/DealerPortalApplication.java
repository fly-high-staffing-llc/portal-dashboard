package com.dealer;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories
public class DealerPortalApplication {

    public static void main(String[] args) {
        SpringApplication.run(DealerPortalApplication.class, args);
    }
} 