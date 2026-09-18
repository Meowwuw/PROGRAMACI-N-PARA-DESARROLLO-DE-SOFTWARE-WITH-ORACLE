package com.perfumeria.backend.service;

import com.perfumeria.backend.model.Venta;
import com.perfumeria.backend.repository.VentaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VentaService {

    @Autowired
    private VentaRepository ventaRepository;

    public List<Venta> obtenerTodasLasVentas() {
        return ventaRepository.findAll();
    }

    public Venta actualizar(int id, Venta venta) {
        venta.setIdVenta(id);
        return ventaRepository.save(venta);
    }
}