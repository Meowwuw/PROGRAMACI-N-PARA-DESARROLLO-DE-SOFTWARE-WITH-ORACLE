package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Cliente;
import com.canchavoley.backend.repository.ClienteRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClienteService {
    private final ClienteRepository clienteRepository;

    public ClienteService(ClienteRepository clienteRepository) {
        this.clienteRepository = clienteRepository;
    }

    // ---- GET ----
    public List<Cliente> listar() {
        return clienteRepository.findAll();
    }

    public Cliente buscarPorId(Long id) {
        return clienteRepository.findById(id).orElse(null);
    }

    public Cliente buscarPorDni(String dni) {
        return clienteRepository.findByDni(dni).orElse(null);
    }

    public List<Cliente> buscarPorApellido(String apellido) {
        return clienteRepository.findByApellidoContainingIgnoreCase(apellido);
    }

    public long contar() {
        return clienteRepository.count();
    }

    // ---- POST ----
    public Cliente guardar(Cliente cliente) {
        return clienteRepository.save(cliente);
    }

    public List<Cliente> guardarVarios(List<Cliente> clientes) {
        return clienteRepository.saveAll(clientes);
    }

    // ---- PUT ----
    public Cliente actualizar(Long id, Cliente datos) {
        Cliente existente = clienteRepository.findById(id).orElse(null);
        if (existente == null) return null;
        existente.setNombre(datos.getNombre());
        existente.setApellido(datos.getApellido());
        existente.setTelefono(datos.getTelefono());
        existente.setDni(datos.getDni());
        return clienteRepository.save(existente);
    }

    public Cliente actualizarTelefono(Long id, Integer telefono) {
        Cliente existente = clienteRepository.findById(id).orElse(null);
        if (existente == null) return null;
        existente.setTelefono(telefono);
        return clienteRepository.save(existente);
    }

    // ---- DELETE ----
    public boolean eliminar(Long id) {
        if (!clienteRepository.existsById(id)) return false;
        clienteRepository.deleteById(id);
        return true;
    }

    public void eliminarPorDni(String dni) {
        clienteRepository.deleteByDni(dni);
    }
}
