package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cliente;
import com.canchavoley.backend.repository.ClienteRepository;
import org.springframework.stereotype.Service;
import java.util.List;

/*
@Service
public class ClienteService {

    public List<Cliente> listar(){
        return List.of(
                new Cliente(1l,"Andres","Acosta", 987654321),
                new Cliente(2l,"Antonio", "Aquiles", 985632147),
                new Cliente(3l,"Alfredo", "Aquino", 963258714)
        );
    }
}
*/

@Service
public class ClienteService {
    private final ClienteRepository clienteRepository;

    public ClienteService(ClienteRepository clienteRepository) {
        this.clienteRepository = clienteRepository;
    }

    public List<Cliente> listar() {
        return clienteRepository.findAll();
    }
}