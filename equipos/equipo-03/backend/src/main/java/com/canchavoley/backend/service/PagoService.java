package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Pago;
import com.canchavoley.backend.repository.PagoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
public class PagoService {

    @Autowired
    private PagoRepository pagoRepository;

    // --- GETs ---
    public List<Pago> obtenerTodos() {
        return pagoRepository.findAll();
    }

    public Optional<Pago> obtenerPorId(Long id) {
        return pagoRepository.findById(id);
    }

    public Optional<Pago> obtenerPorReserva(Long idReserva) {
        return pagoRepository.findByReservaIdReserva(idReserva);
    }

    public BigDecimal obtenerSumaTotal() {
        BigDecimal total = pagoRepository.sumarTotalPagos();
        return total != null ? total : BigDecimal.ZERO;
    }

    public long contarTodos() {
        return pagoRepository.count();
    }

    // --- POSTs ---
    public Pago guardar(Pago pago) {
        return pagoRepository.save(pago);
    }

    public List<Pago> guardarVarios(List<Pago> pagos) {
        return pagoRepository.saveAll(pagos);
    }

    // --- PUTs ---
    public Pago actualizar(Long id, Pago detalles) {
        Pago pago = pagoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pago no encontrado con id: " + id));
        pago.setReserva(detalles.getReserva());
        pago.setTotal(detalles.getTotal());
        return pagoRepository.save(pago);
    }

    public Pago actualizarMonto(Long id, BigDecimal nuevoTotal) {
        Pago pago = pagoRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Pago no encontrado con id: " + id));
        pago.setTotal(nuevoTotal);
        return pagoRepository.save(pago);
    }

    // --- DELETEs ---
    public void eliminarPorId(Long id) {
        pagoRepository.deleteById(id);
    }

    @Transactional
    public void eliminarPorReserva(Long idReserva) {
        pagoRepository.deleteByReservaIdReserva(idReserva);
    }
}