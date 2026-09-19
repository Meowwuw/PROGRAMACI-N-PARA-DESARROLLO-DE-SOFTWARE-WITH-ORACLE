package com.canchavoley.backend.controller;

import com.canchavoley.backend.model.Cancha;
import com.canchavoley.backend.service.CanchaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/canchas")
@CrossOrigin(origins = "*")
public class CanchaController {

    @Autowired
    private CanchaService canchaService;

    // ==========================================
    // 5 ENDPOINTS GET
    // ==========================================

    // GET 1: Listar todas las canchas
    @GetMapping
    public List<Cancha> listarTodas() {
        return canchaService.obtenerTodas();
    }

    // GET 2: Buscar cancha por ID
    @GetMapping("/{id}")
    public ResponseEntity<Cancha> buscarPorId(@PathVariable Long id) {
        return canchaService.obtenerPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 3: Buscar cancha por número de cancha
    @GetMapping("/numero/{numero}")
    public ResponseEntity<Cancha> buscarPorNumero(@PathVariable Integer numero) {
        return canchaService.obtenerPorNumero(numero)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // GET 4: Verificar existencia de una cancha por número
    @GetMapping("/existe/{numero}")
    public ResponseEntity<Boolean> existePorNumero(@PathVariable Integer numero) {
        return ResponseEntity.ok(canchaService.existePorNumero(numero));
    }

    // GET 5: Obtener la cantidad total de canchas
    @GetMapping("/conteo")
    public ResponseEntity<Long> contarCanchas() {
        return ResponseEntity.ok(canchaService.contarTodas());
    }

    // ==========================================
    // 2 ENDPOINTS POST
    // ==========================================

    // POST 1: Registrar una sola cancha
    @PostMapping
    public ResponseEntity<Cancha> crearCancha(@RequestBody Cancha cancha) {
        return new ResponseEntity<>(canchaService.guardar(cancha), HttpStatus.CREATED);
    }

    // POST 2: Registrar un listado de canchas en lote
    @PostMapping("/lote")
    public ResponseEntity<List<Cancha>> crearCanchasEnLote(@RequestBody List<Cancha> canchas) {
        return new ResponseEntity<>(canchaService.guardarVarias(canchas), HttpStatus.CREATED);
    }

    // ==========================================
    // 2 ENDPOINTS PUT
    // ==========================================

    // PUT 1: Actualización completa de cancha por ID
    @PutMapping("/{id}")
    public ResponseEntity<Cancha> actualizarCancha(@PathVariable Long id, @RequestBody Cancha cancha) {
        return ResponseEntity.ok(canchaService.actualizar(id, cancha));
    }

    // PUT 2: Actualizar únicamente el número de la cancha
    @PutMapping("/{id}/numero")
    public ResponseEntity<Cancha> actualizarNumeroCancha(@PathVariable Long id, @RequestParam Integer nuevoNumero) {
        return ResponseEntity.ok(canchaService.actualizarNumero(id, nuevoNumero));
    }

    // ==========================================
    // 2 ENDPOINTS DELETE
    // ==========================================

    // DELETE 1: Eliminar cancha por su ID
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarPorId(@PathVariable Long id) {
        canchaService.eliminarPorId(id);
        return ResponseEntity.noContent().build();
    }

    // DELETE 2: Eliminar cancha por su número
    @DeleteMapping("/numero/{numero}")
    public ResponseEntity<Void> eliminarPorNumero(@PathVariable Integer numero) {
        canchaService.eliminarPorNumero(numero);
        return ResponseEntity.noContent().build();
    }
}