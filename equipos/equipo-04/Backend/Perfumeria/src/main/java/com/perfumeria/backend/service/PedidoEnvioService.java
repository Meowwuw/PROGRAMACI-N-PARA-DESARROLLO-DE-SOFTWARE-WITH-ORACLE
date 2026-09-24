package com.perfumeria.backend.service;

import com.perfumeria.backend.model.PedidoEnvio;
import com.perfumeria.backend.repository.PedidoEnvioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class PedidoEnvioService {

    @Autowired
    private PedidoEnvioRepository pedidoEnvioRepository;

    public List<PedidoEnvio> listarTodos() {
        return pedidoEnvioRepository.findAll();
    }

    public Optional<PedidoEnvio> buscarPorId(Long id) {
        return pedidoEnvioRepository.findById(id);
    }

    public PedidoEnvio guardar(PedidoEnvio pedido) {
        return pedidoEnvioRepository.save(pedido);
    }

    public PedidoEnvio actualizar(Long id, PedidoEnvio actualizado) {
        return pedidoEnvioRepository.findById(id)
                .map(p -> {
                    p.setIdVenta(actualizado.getIdVenta());
                    p.setFechaPedido(actualizado.getFechaPedido());
                    p.setFechaEntrega(actualizado.getFechaEntrega());
                    p.setEstadoEnvio(actualizado.getEstadoEnvio());
                    return pedidoEnvioRepository.save(p);
                })
                .orElse(null);
    }

    public boolean eliminar(Long id) {
        if (pedidoEnvioRepository.existsById(id)) {
            pedidoEnvioRepository.deleteById(id);
            return true;
        }
        return false;
    }
}
