package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Pago;
import com.VoleyPlay.backend.services.PagoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pago")
public class PagoController {
    private final PagoService pagoService;

    public PagoController(PagoService pagoService) {
        this.pagoService = pagoService;
    }

    @GetMapping
    public List<Pago> listar() {
        return pagoService.listar();
    }
    @PutMapping("/{id}")
        public Pago actualizar(
                @PathVariable long id,
                @RequestBody Pago pago){
        return pagoService.actualizar(id, pago);
    }
    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id){
        pagoService.eliminar(id);
    }
}
