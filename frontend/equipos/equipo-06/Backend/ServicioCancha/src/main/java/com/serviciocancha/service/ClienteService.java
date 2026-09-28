package com.serviciocancha.service;

import com.serviciocancha.model.Cliente;
import com.serviciocancha.model.MetodoPago;
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

        return clienteRepository.save(cliente);
    }

    public void eliminar(Integer id) {
        clienteRepository.deleteById(id);
    }
}