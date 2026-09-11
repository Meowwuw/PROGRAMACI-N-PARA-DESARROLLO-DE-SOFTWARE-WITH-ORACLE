package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Cliente;
import com.VoleyPlay.backend.repository.ClienteRepository;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Service
public class ClienteService {
    private final ClienteRepository clienteRepository;

    public ClienteService(ClienteRepository clienteRepository){
        this.clienteRepository=clienteRepository;
    }
    public List<Cliente> listar(){
        return clienteRepository.findAll();
    }
}