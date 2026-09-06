package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Cliente;
import com.VoleyPlay.backend.services.ClienteService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/cliente")
public class ClienteController {
    private final ClienteService clienteService;

    public ClienteController(ClienteService clienteService) {
        this.clienteService = clienteService;
    }

    @GetMapping
    public List<Cliente> listar() {
        return clienteService.listar();
    }

    @GetMapping("/destacado")
    public Cliente destacado() {
        return new Cliente(
                1L,
                "Cliente Destacado",
                "Platino",
                "99999999",
                "900000000",
                "destacado@mail.com");
    }

    @GetMapping("{id}")
    public Cliente buscarPorId(@PathVariable Long id) {
        return new Cliente(
                id,
                "Cliente prueba",
                "Sin identificar",
                "00000000",
                "000000000",
                "prueba@mail.com");
    }
}