package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Cliente;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Service
public class ClienteService {
    @GetMapping
    public List<Cliente> listar() {
        return List.of(
                new Cliente(1L, "Ana", "García", "12345678", "987654321", "ana@mail.com"),
                new Cliente(2L, "Luis", "Pérez", "87654321", "912345678", "luis@mail.com"),
                new Cliente(3L, "María", "López", "11223344", "998877665", "maria@mail.com")
        );
    }
}