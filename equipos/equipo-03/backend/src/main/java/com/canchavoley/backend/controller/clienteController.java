package com.canchavoley.backend.controller;
import com.canchavoley.backend.model.Cliente;

import com.canchavoley.backend.repository.ClienteRepository;
import com.canchavoley.backend.service.ClienteService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/clientes")
public class clienteController {
    private final ClienteService clienteService;

    public clienteController(ClienteService clienteService){
        this.clienteService=clienteService;
    }

    @GetMapping
    public List<Cliente> listar(){
        return clienteService.listar();
    }

    @GetMapping("/{id}")
    public Cliente buscarPorId(@PathVariable Long id) {
        return clienteService.buscarPorId(id);
    }

    @PostMapping
    public Cliente guardar(@RequestBody Cliente cliente) {
        return clienteService.guardar(cliente);
    }

}
