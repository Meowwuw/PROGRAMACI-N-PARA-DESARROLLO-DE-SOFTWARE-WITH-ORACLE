package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Pago;
import com.canchavoley.backend.service.PagoService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/pagos")
public class pagoController {
    private final PagoService pagoService;

    public pagoController(PagoService pagoService) {
        this.pagoService = pagoService;
    }

    // ---- GET (5) ----
    @GetMapping
    public List<Pago> listar() {
        return pagoService.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Pago> buscarPorId(@PathVariable Long id) {
        Pago pago = pagoService.buscarPorId(id);
        return pago != null ? ResponseEntity.ok(pago) : ResponseEntity.notFound().build();
    }

    @GetMapping("/reserva/{idReserva}")
    public List<Pago> buscarPorReserva(@PathVariable Long idReserva) {
        return pagoService.buscarPorReserva(idReserva);
    }

    @GetMapping("/total-minimo/{total}")
    public List<Pago> listarConTotalMinimo(@PathVariable Double total) {
        return pagoService.listarConTotalMinimo(total);
    }

    @GetMapping("/count")
    public long contar() {
        return pagoService.contar();
    }

    // ---- POST (2) ----
    @PostMapping
    public Pago registrar(@RequestBody Pago pago) {
        return pagoService.guardar(pago);
    }

    @PostMapping("/lote")
    public List<Pago> registrarVarios(@RequestBody List<Pago> pagos) {
        return pagoService.guardarVarios(pagos);
    }

    // ---- PUT (2) ----
    @PutMapping("/{id}")
    public ResponseEntity<Pago> actualizar(@PathVariable Long id, @RequestBody Pago pago) {
        Pago actualizado = pagoService.actualizar(id, pago);
        return actualizado != null ? ResponseEntity.ok(actualizado) : ResponseEntity.notFound().build();
    }

    @PutMapping("/{id}/total")
    public ResponseEntity<Pago> actualizarTotal(@PathVariable Long id, @RequestBody Double total) {
        Pago actualizado = pagoService.actualizarTotal(id, total);
        return actualizado != null ? ResponseEntity.ok(actualizado) : ResponseEntity.notFound().build();
    }

    // ---- DELETE (2) ----
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        return pagoService.eliminar(id) ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/reserva/{idReserva}")
    public ResponseEntity<Void> eliminarPorReserva(@PathVariable Long idReserva) {
        pagoService.eliminarPorReserva(idReserva);
        return ResponseEntity.noContent().build();
    }
}
