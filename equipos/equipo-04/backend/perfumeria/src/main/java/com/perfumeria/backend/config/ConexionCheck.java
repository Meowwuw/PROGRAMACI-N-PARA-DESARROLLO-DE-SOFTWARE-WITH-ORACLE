package com.perfumeria.backend.config;

import org.springframework.boot.CommandLineRunner;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

@Component
public class ConexionCheck implements CommandLineRunner{
    private final JdbcTemplate jdbcTemplate;

    public ConexionCheck(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public void run(String... args){
        jdbcTemplate.queryForObject("SELECT 1",Integer.class);
        System.out.println("CONEXION EXITOSA");
    }
}
