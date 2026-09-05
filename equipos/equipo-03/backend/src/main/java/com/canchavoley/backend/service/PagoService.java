package com.canchavoley.backend.service;

import com.canchavoley.backend.model.Pago;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PagoService {
    public List<Pago> listar(){
        return List.of(
                new Pago(1l,1L, 25.00),
                new Pago(2l,2L, 30.00),
                new Pago(3l,3L, 50.00)
        );
    }
}
