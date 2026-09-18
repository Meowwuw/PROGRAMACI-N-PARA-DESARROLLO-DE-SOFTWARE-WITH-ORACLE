package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Pago;
import com.canchavoley.backend.repository.PagoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PagoService {

    private final PagoRepository pagoRepository;

    public PagoService(PagoRepository pagoRepository) {
        this.pagoRepository = pagoRepository;
    }

    // ---- GET ----
    public List<Pago> listar() {
        return pagoRepository.findAll();
    }

    public Pago buscarPorId(Long id) {
        return pagoRepository.findById(id).orElse(null);
    }

    public List<Pago> buscarPorReserva(Long idReserva) {
        return pagoRepository.findByIdReserva(idReserva);
    }

    public List<Pago> listarConTotalMinimo(Double total) {
        return pagoRepository.findByTotalGreaterThanEqual(total);
    }

    public long contar() {
        return pagoRepository.count();
    }

    // ---- POST ----
    public Pago guardar(Pago pago) {
        return pagoRepository.save(pago);
    }

    public List<Pago> guardarVarios(List<Pago> pagos) {
        return pagoRepository.saveAll(pagos);
    }

    // ---- PUT ----
    public Pago actualizar(Long id, Pago datos) {
        Pago existente = pagoRepository.findById(id).orElse(null);
        if (existente == null) return null;
        existente.setIdReserva(datos.getIdReserva());
        existente.setTotal(datos.getTotal());
        return pagoRepository.save(existente);
    }

    public Pago actualizarTotal(Long id, Double total) {
        Pago existente = pagoRepository.findById(id).orElse(null);
        if (existente == null) return null;
        existente.setTotal(total);
        return pagoRepository.save(existente);
    }

    // ---- DELETE ----
    public boolean eliminar(Long id) {
        if (!pagoRepository.existsById(id)) return false;
        pagoRepository.deleteById(id);
        return true;
    }

    public void eliminarPorReserva(Long idReserva) {
        pagoRepository.deleteByIdReserva(idReserva);
    }
}
