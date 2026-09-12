package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Pago;
import com.VoleyPlay.backend.repository.PagoRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class PagoService {
    private final PagoRepository pagoRepository;

    public PagoService(PagoRepository productoRepository){
        this.pagoRepository=productoRepository;
    }

    public List<Pago> listar(){
        return pagoRepository.findAll();
    }
}
