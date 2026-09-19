package com.serviciocancha.service;

import com.serviciocancha.model.Cliente;
import com.serviciocancha.repository.ClienteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ClienteService {

    @Autowired
    private ClienteRepository clienteRepository;

    public List<Cliente> listar() {
        return clienteRepository.findAll();
    }

    public Cliente buscarPorId(Integer id) {
        return clienteRepository.findById(id).orElse(null);
    }

    public Cliente buscarPorDni(String dni) {
        return clienteRepository.findByDni(dni).orElse(null);
    }

    // Nuevo método para buscar cliente por Email
    public Cliente buscarPorEmail(String email) {
        return clienteRepository.findByEmail(email).orElse(null);
    }

    // Nuevo método opcional para procesar un inicio de sesión
    public Cliente login(String email, String password) {
        Cliente cliente = clienteRepository.findByEmail(email).orElse(null);
        if (cliente != null && cliente.getPassword().equals(password)) {
            return cliente; // Login exitoso
        }
        return null; // Credenciales inválidas
    }

    public Cliente guardar(Cliente cliente) {
        return clienteRepository.save(cliente);
    }

    public Cliente actualizar(Integer id, Cliente datos) {
        Cliente cliente = clienteRepository.findById(id)
                .orElse(null);

        if (cliente == null) {
            return null;
        }

        cliente.setNombre(datos.getNombre());
        cliente.setTelefono(datos.getTelefono());
        cliente.setDni(datos.getDni());

        // Se agregan las actualizaciones de email y password
        cliente.setEmail(datos.getEmail());
        cliente.setPassword(datos.getPassword());

        return clienteRepository.save(cliente);
    }

    public void eliminar(Integer id) {
        clienteRepository.deleteById(id);
    }
}