package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Pago;
import com.VoleyPlay.backend.repository.PagoRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PagoService {
    private final PagoRepository pagoRepository;

    public PagoService(PagoRepository pagoRepository) {
        this.pagoRepository = pagoRepository;
    }

    public List<Pago> listar() {
        return pagoRepository.findAll();
    }

    public Pago buscarPorId(Long id) {
        return pagoRepository.findById(id)
                .orElse(null);
    }

    public Pago guardar(Pago pago) {
        return pagoRepository.save(pago);
    }

    public Pago actualizar(Long id, Pago datos) {
        Pago pago = pagoRepository.findById(id)
                .orElse(null);

        if (pago == null) {
            return null;
        }

        pago.setIdReserva(datos.getIdReserva());
        pago.setFechaPago(datos.getFechaPago());
        pago.setMonto(datos.getMonto());
        pago.setMetodoPago(datos.getMetodoPago());
        pago.setEstado(datos.getEstado());

        return pagoRepository.save(pago);
    }

    public void eliminar(Long id) {
        pagoRepository.deleteById(id);
    }
}