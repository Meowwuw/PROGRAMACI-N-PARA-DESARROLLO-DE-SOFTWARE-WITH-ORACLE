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

    public Pago guardar(Pago pago) {
        return pagoRepository.save(pago);
    }

    public Pago actualizar(Long id, Pago datos) {
        return pagoRepository.findById(id).map(pago -> {
            // Actualiza los campos necesarios de 'pago' usando 'datos'
            return pagoRepository.save(pago);
        }).orElse(null);
    }

    public void eliminar(Long id) {
        pagoRepository.deleteById(id);
    }
}