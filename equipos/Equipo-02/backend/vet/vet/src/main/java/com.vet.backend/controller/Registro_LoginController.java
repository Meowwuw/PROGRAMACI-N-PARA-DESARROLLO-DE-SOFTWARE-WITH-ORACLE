package com.vet.backend.controller;

import com.vet.backend.dto.Registro_LoginPatchRequest;
import com.vet.backend.dto.Registro_LoginRequest;
import com.vet.backend.dto.Registro_LoginResponse;
import com.vet.backend.service.Registro_LoginService;
import jakarta.validation.Valid;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.net.URI;
import java.util.Map;

@RestController
@RequestMapping("/api/registro-login")
public class Registro_LoginController {

    private final Registro_LoginService service;

    public Registro_LoginController(Registro_LoginService service) {
        this.service = service;
    }

    // GET /api/registro-login?idUsuario=3&username=jhidalgo&exito=false&page=0&size=20
    @GetMapping
    public Page<Registro_LoginResponse> listar(
            @RequestParam(required = false) Integer idUsuario,
            @RequestParam(required = false) String username,
            @RequestParam(required = false) Boolean exito,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {
        var pageable = PageRequest.of(page, Math.min(size, 100),
                Sort.by(Sort.Direction.DESC, "fechaHora"));
        return service.listar(idUsuario, username, exito, pageable);
    }

    // GET /api/registro-login/5
    @GetMapping("/{id}")
    public Registro_LoginResponse obtener(@PathVariable Integer id) {
        return service.obtenerPorId(id);
    }

    // GET /api/registro-login/fallidos/count?username=admin&minutos=15
    @GetMapping("/fallidos/count")
    public Map<String, Object> contarFallidos(@RequestParam String username,
                                              @RequestParam(defaultValue = "15") int minutos) {
        return Map.of("username", username,
                "minutos", minutos,
                "fallidos", service.contarFallidosRecientes(username, minutos));
    }

    // HEAD /api/registro-login/5  -> 200 si existe, 404 si no (sin cuerpo)
    @RequestMapping(value = "/{id}", method = RequestMethod.HEAD)
    public ResponseEntity<Void> existe(@PathVariable Integer id) {
        return service.existe(id) ? ResponseEntity.ok().build()
                : ResponseEntity.notFound().build();
    }

    // POST /api/registro-login
    @PostMapping
    public ResponseEntity<Registro_LoginResponse> crear(@Valid @RequestBody Registro_LoginRequest req) {
        Registro_LoginResponse creado = service.crear(req);
        URI location = ServletUriComponentsBuilder.fromCurrentRequest()
                .path("/{id}").buildAndExpand(creado.idRegistro()).toUri();
        return ResponseEntity.created(location).body(creado);
    }

    // PUT /api/registro-login/5  (reemplazo completo)
    @PutMapping("/{id}")
    public Registro_LoginResponse actualizar(@PathVariable Integer id,
                                             @Valid @RequestBody Registro_LoginRequest req) {
        return service.actualizar(id, req);
    }

    // PATCH /api/registro-login/5  (actualizacion parcial)
    @PatchMapping("/{id}")
    public Registro_LoginResponse actualizarParcial(@PathVariable Integer id,
                                                    @Valid @RequestBody Registro_LoginPatchRequest req) {
        return service.actualizarParcial(id, req);
    }

    // DELETE /api/registro-login/5
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Integer id) {
        service.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}