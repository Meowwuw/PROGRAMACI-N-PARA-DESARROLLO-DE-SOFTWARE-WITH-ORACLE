package com.vet.backend.controller;

import com.vet.backend.dto.RolPatchRequest;
import com.vet.backend.dto.RolRequest;
import com.vet.backend.dto.RolResponse;
import com.vet.backend.service.RolService;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/roles")
public class RolController {

    private final RolService service;

    public RolController(RolService service) {
        this.service = service;
    }

    // GET /api/roles
    @GetMapping
    public List<RolResponse> listar() {
        return service.listar();
    }

    // GET /api/roles/4
    @GetMapping("/{id}")
    public RolResponse obtener(@PathVariable Integer id) {
        return service.obtenerPorId(id);
    }

    // GET /api/roles/nombre/admin
    @GetMapping("/nombre/{nombre}")
    public RolResponse obtenerPorNombre(@PathVariable String nombre) {
        return service.obtenerPorNombre(nombre);
    }

    // HEAD /api/roles/4  -> 200 si existe, 404 si no (sin cuerpo)
    @RequestMapping(value = "/{id}", method = RequestMethod.HEAD)
    public ResponseEntity<Void> existe(@PathVariable Integer id) {
        return service.existe(id) ? ResponseEntity.ok().build()
                : ResponseEntity.notFound().build();
    }

    // POST /api/roles
    @PostMapping
    public ResponseEntity<RolResponse> crear(@Valid @RequestBody RolRequest req) {
        RolResponse creado = service.crear(req);
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}").buildAndExpand(creado.idRol()).toUri();
        return ResponseEntity.created(location).body(creado);
    }

    // PUT /api/roles/4
    @PutMapping("/{id}")
    public RolResponse actualizar(@PathVariable Integer id,
                                  @Valid @RequestBody RolRequest req) {
        return service.actualizar(id, req);
    }

    // PATCH /api/roles/4
    @PatchMapping("/{id}")
    public RolResponse actualizarParcial(@PathVariable Integer id,
                                         @Valid @RequestBody RolPatchRequest req) {
        return service.actualizarParcial(id, req);
    }

    // DELETE /api/roles/5
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        service.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}