package com.VoleyPlay.backend.repository;

import com.VoleyPlay.backend.model.Cliente;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ClienteRepository
        extends JpaRepository <Cliente, Long> {

}

