package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Pago;
import com.canchavoley.backend.service.PagoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/api/pagos")
@CrossOrigin(origins = "*")
public class PagoController {

    @Autowired
    private PagoService pagoService;

    // ==========================================
    // 5 ENDPOINTS GET
    // ==========================================

    // GET 1: Listar todos los pagos
    @GetMapping
    public List<Pago> listarTodos() {
        return pagoService.obtenerTodos();
    }

    // GET 2: Buscar pago por ID
    @GetMapping("/{id}")
    public ResponseEntity<Pago> buscarPorId(@PathVariable Long id) {
        return pagoService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 3: Buscar pago asociado al ID de una reserva
    @GetMapping("/reserva/{idReserva}")
    public ResponseEntity<Pago> buscarPorReserva(@PathVariable Long idReserva) {
        return pagoService.obtenerPorReserva(idReserva)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 4: Obtener la suma total recaudada de todos los pagos
    @GetMapping("/recaudacion-total")
    public ResponseEntity<BigDecimal> obtenerRecaudacionTotal() {
        return ResponseEntity.ok(pagoService.obtenerSumaTotal());
    }

    // GET 5: Contar total de transacciones de pago registradas
    @GetMapping("/conteo")
    public ResponseEntity<Long> contarPagos() {
        return ResponseEntity.ok(pagoService.contarTodos());
    }

    // ==========================================
    // 2 ENDPOINTS POST
    // ==========================================

    // POST 1: Registrar un pago
    @PostMapping
    public ResponseEntity<Pago> crearPago(@RequestBody Pago pago) {
        return new ResponseEntity<>(pagoService.guardar(pago), HttpStatus.CREATED);
    }

    // POST 2: Registrar pagos en lote
    @PostMapping("/lote")
    public ResponseEntity<List<Pago>> crearPagosEnLote(@RequestBody List<Pago> pagos) {
        return new ResponseEntity<>(pagoService.guardarVarios(pagos), HttpStatus.CREATED);
    }

    // ==========================================
    // 2 ENDPOINTS PUT
    // ==========================================

    // PUT 1: Actualizar datos completos del pago
    @PutMapping("/{id}")
    public ResponseEntity<Pago> actualizarPago(@PathVariable Long id, @RequestBody Pago pago) {
        return ResponseEntity.ok(pagoService.actualizar(id, pago));
    }

    // PUT 2: Actualizar únicamente el monto pagado
    @PutMapping("/{id}/total")
    public ResponseEntity<Pago> actualizarMontoPago(@PathVariable Long id, @RequestParam BigDecimal nuevoTotal) {
        return ResponseEntity.ok(pagoService.actualizarMonto(id, nuevoTotal));
    }

    // ==========================================
    // 2 ENDPOINTS DELETE
    // ==========================================

    // DELETE 1: Eliminar pago por su ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPorId(@PathVariable Long id) {
        pagoService.eliminarPorId(id);
        return ResponseEntity.noContent().build();
    }

    // DELETE 2: Eliminar pago asociado a una reserva específica
    @DeleteMapping("/reserva/{idReserva}")
    public ResponseEntity<Void> eliminarPorReserva(@PathVariable Long idReserva) {
        pagoService.eliminarPorReserva(idReserva);
        return ResponseEntity.noContent().build();
    }
}