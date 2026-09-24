package com.perfumeria.backend.service;

import com.perfumeria.backend.model.Cliente;
import com.perfumeria.backend.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ClienteService {

    @Autowired
    private ClienteRepository clienteRepository;

    public List<Cliente> obtenerTodosLosClientes() {
        return clienteRepository.findAll();
    }

    // Faltaba: buscar por id
    public Optional<Cliente> buscarPorId(Long id) {
        return clienteRepository.findById(id);
    }

    // Faltaba: guardar (crear)
    public Cliente guardar(Cliente cliente) {
        return clienteRepository.save(cliente);
    }

    // Ya existía, se deja igual
    public Cliente actualizar(Long id, Cliente clienteActualizado) {
        return clienteRepository.findById(id)
                .map(cliente -> {
                    cliente.setNombre(clienteActualizado.getNombre());
                    cliente.setApellido(clienteActualizado.getApellido());
                    cliente.setDniRuc(clienteActualizado.getDniRuc());
                    cliente.setTelefono(clienteActualizado.getTelefono());
                    cliente.setEmail(clienteActualizado.getEmail());
                    cliente.setDireccion(clienteActualizado.getDireccion());
                    return clienteRepository.save(cliente);
                })
                .orElse(null);
    }

    // Faltaba: eliminar
    public boolean eliminar(Long id) {
        if (clienteRepository.existsById(id)) {
            clienteRepository.deleteById(id);
            return true;
        }
        return false;
    }
}