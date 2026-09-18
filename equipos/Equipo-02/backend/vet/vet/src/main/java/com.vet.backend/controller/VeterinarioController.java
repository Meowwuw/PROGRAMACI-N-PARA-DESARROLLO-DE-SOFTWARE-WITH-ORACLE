package com.vet.backend.controller;

import com.vet.backend.model.Veterinario;
import com.vet.backend.service.VeterinarioService;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/veterinarios")
public class VeterinarioController {

    @Autowired
    private VeterinarioService veterinarioService;

    // ======================= GET (5) =======================

    // 1. Listar todos los veterinarios
    @GetMapping
    public ResponseEntity<List<Veterinario>> listarTodos() {
        return ResponseEntity.ok(veterinarioService.listarTodos());
    }

    // 2. Obtener un veterinario por id
    @GetMapping("/{id}")
    public ResponseEntity<?> obtenerPorId(@PathVariable Long id) {
        try {
            return ResponseEntity.ok(veterinarioService.obtenerPorId(id));
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", e.getMessage()));
        }
    }

    // 3. Obtener veterinarios por especialidad
    @GetMapping("/especialidad/{especialidad}")
    public ResponseEntity<List<Veterinario>> obtenerPorEspecialidad(@PathVariable String especialidad) {
        return ResponseEntity.ok(veterinarioService.obtenerPorEspecialidad(especialidad));
    }

    // 4. Obtener un veterinario por telefono
    @GetMapping("/telefono/{telefono}")
    public ResponseEntity<?> obtenerPorTelefono(@PathVariable String telefono) {
        try {
            return ResponseEntity.ok(veterinarioService.obtenerPorTelefono(telefono));
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", e.getMessage()));
        }
    }

    // 5. Buscar veterinarios por nombre (coincidencia parcial)
    @GetMapping("/buscar")
    public ResponseEntity<List<Veterinario>> buscarPorNombre(@RequestParam String nombre) {
        return ResponseEntity.ok(veterinarioService.buscarPorNombre(nombre));
    }

    // ======================= POST (2) =======================

    // 1. Crear un nuevo veterinario
    @PostMapping
    public ResponseEntity<Veterinario> crear(@RequestBody Veterinario veterinario) {
        Veterinario creado = veterinarioService.crear(veterinario);
        return ResponseEntity.status(HttpStatus.CREATED).body(creado);
    }

    // 2. Crear varios veterinarios en lote
    @PostMapping("/lote")
    public ResponseEntity<List<Veterinario>> crearEnLote(@RequestBody List<Veterinario> veterinarios) {
        List<Veterinario> creados = veterinarioService.crearEnLote(veterinarios);
        return ResponseEntity.status(HttpStatus.CREATED).body(creados);
    }

    // ======================= PUT (2) =======================

    // 1. Actualizar todos los datos de un veterinario
    @PutMapping("/{id}")
    public ResponseEntity<?> actualizar(@PathVariable Long id, @RequestBody Veterinario veterinario) {
        try {
            return ResponseEntity.ok(veterinarioService.actualizar(id, veterinario));
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", e.getMessage()));
        }
    }

    // 2. Actualizar solo el telefono de un veterinario
    @PutMapping("/{id}/telefono")
    public ResponseEntity<?> actualizarTelefono(@PathVariable Long id, @RequestBody Map<String, String> body) {
        try {
            String telefono = body.get("telefono");
            return ResponseEntity.ok(veterinarioService.actualizarTelefono(id, telefono));
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", e.getMessage()));
        }
    }

    // ======================= DELETE (2) =======================

    // 1. Eliminar un veterinario por id
    @DeleteMapping("/{id}")
    public ResponseEntity<?> eliminarPorId(@PathVariable Long id) {
        try {
            veterinarioService.eliminarPorId(id);
            return ResponseEntity.noContent().build();
        } catch (EntityNotFoundException e) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(Map.of("error", e.getMessage()));
        }
    }

    // 2. Eliminar todos los veterinarios de una especialidad
    @DeleteMapping("/especialidad/{especialidad}")
    public ResponseEntity<?> eliminarPorEspecialidad(@PathVariable String especialidad) {
        int eliminados = veterinarioService.eliminarPorEspecialidad(especialidad);
        return ResponseEntity.ok(Map.of("eliminados", eliminados));
    }
}