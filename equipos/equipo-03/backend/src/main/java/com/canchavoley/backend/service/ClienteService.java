package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cliente;
import com.canchavoley.backend.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
public class ClienteService {

    @Autowired
    private ClienteRepository clienteRepository;

    // --- GETs ---
    public List<Cliente> obtenerTodos() {
        return clienteRepository.findAll();
    }

    public Optional<Cliente> obtenerPorId(Long id) {
        return clienteRepository.findById(id);
    }

    public Optional<Cliente> obtenerPorDni(String dni) {
        return clienteRepository.findByDni(dni);
    }

    public boolean existePorDni(String dni) {
        return clienteRepository.existsByDni(dni);
    }

    public long contarTodos() {
        return clienteRepository.count();
    }

    // --- POSTs ---
    public Cliente guardar(Cliente cliente) {
        return clienteRepository.save(cliente);
    }

    public List<Cliente> guardarVarios(List<Cliente> clientes) {
        return clienteRepository.saveAll(clientes);
    }

    // --- PUTs ---
    public Cliente actualizar(Long id, Cliente clienteDetalles) {
        Cliente cliente = clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado con id: " + id));
        cliente.setNombre(clienteDetalles.getNombre());
        cliente.setApellido(clienteDetalles.getApellido());
        cliente.setTelefono(clienteDetalles.getTelefono());
        cliente.setDni(clienteDetalles.getDni());
        return clienteRepository.save(cliente);
    }

    public Cliente actualizarTelefono(Long id, String nuevoTelefono) {
        Cliente cliente = clienteRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Cliente no encontrado con id: " + id));
        cliente.setTelefono(nuevoTelefono);
        return clienteRepository.save(cliente);
    }

    // --- DELETEs ---
    public void eliminarPorId(Long id) {
        clienteRepository.deleteById(id);
    }

    @Transactional
    public void eliminarPorDni(String dni) {
        clienteRepository.deleteByDni(dni);
    }
}