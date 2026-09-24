package com.perfumeria.backend.service;

import com.perfumeria.backend.model.DetalleVenta;
import com.perfumeria.backend.repository.DetalleVentaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class DetalleVentaService {

    @Autowired
    private DetalleVentaRepository detalleVentaRepository;

    public List<DetalleVenta> listarTodos() {
        return detalleVentaRepository.findAll();
    }

    public Optional<DetalleVenta> buscarPorId(Long id) {
        return detalleVentaRepository.findById(id);
    }

    public DetalleVenta guardar(DetalleVenta detalle) {
        return detalleVentaRepository.save(detalle);
    }

    public DetalleVenta actualizar(Long id, DetalleVenta actualizado) {
        return detalleVentaRepository.findById(id)
                .map(d -> {
                    d.setIdVenta(actualizado.getIdVenta());
                    d.setIdPerfume(actualizado.getIdPerfume());
                    d.setCantidad(actualizado.getCantidad());
                    d.setPrecioUnitario(actualizado.getPrecioUnitario());
                    d.setDescuento(actualizado.getDescuento());
                    return detalleVentaRepository.save(d);
                })
                .orElse(null);
    }

    public boolean eliminar(Long id) {
        if (detalleVentaRepository.existsById(id)) {
            detalleVentaRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
