package com.vet.backend.controller;

import com.vet.backend.model.Apoderado;
import com.vet.backend.model.Consulta;
import com.vet.backend.model.Mascota;
import com.vet.backend.model.Veterinario;
import com.vet.backend.repository.ApoderadoRepository;
import com.vet.backend.repository.MascotaRepository;
import com.vet.backend.repository.VeterinarioRepository;
import com.vet.backend.service.ConsultaService;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/api/consultas")
@CrossOrigin(origins = "http://localhost:5173")
public class ConsultaController {

    private final ConsultaService consultaService;
    private final ApoderadoRepository apoderadoRepository;
    private final VeterinarioRepository veterinarioRepository;
    private final MascotaRepository mascotaRepository;

    public ConsultaController(ConsultaService consultaService,
                              ApoderadoRepository apoderadoRepository,
                              VeterinarioRepository veterinarioRepository,
                              MascotaRepository mascotaRepository) {
        this.consultaService = consultaService;
        this.apoderadoRepository = apoderadoRepository;
        this.veterinarioRepository = veterinarioRepository;
        this.mascotaRepository = mascotaRepository;
    }

    // ---------- GET (5) ----------

    @GetMapping
    public List<Consulta> listar() {
        return consultaService.listar();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Consulta> buscarPorId(@PathVariable Long id) {
        return consultaService.buscarPorId(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @GetMapping("/mascota/{idMascota}")
    public List<Consulta> listarPorMascota(@PathVariable Long idMascota) {
        return consultaService.listarPorMascota(idMascota);
    }

    @GetMapping("/veterinario/{idVeterinario}")
    public List<Consulta> listarPorVeterinario(@PathVariable Long idVeterinario) {
        return consultaService.listarPorVeterinario(idVeterinario);
    }

    @GetMapping("/fecha")
    public List<Consulta> listarPorRangoFecha(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime inicio,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime fin) {
        return consultaService.listarPorRangoFecha(inicio, fin);
    }

    // ---------- POST (2) ----------

    @PostMapping
    public ResponseEntity<Consulta> crear(@RequestBody Consulta consulta) {
        Consulta nueva = consultaService.guardar(consulta);
        return ResponseEntity.status(HttpStatus.CREATED).body(nueva);
    }

    @PostMapping("/rapida")
    public ResponseEntity<Consulta> crearRapida(
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime fecha,
            @RequestParam Long idApoderado,
            @RequestParam Long idVeterinario,
            @RequestParam Long idMascota) {

        Apoderado apoderado = apoderadoRepository.findById(idApoderado)
                .orElseThrow(() -> new RuntimeException("Apoderado no encontrado"));
        Veterinario veterinario = veterinarioRepository.findById(idVeterinario)
                .orElseThrow(() -> new RuntimeException("Veterinario no encontrado"));
        Mascota mascota = mascotaRepository.findById(idMascota)
                .orElseThrow(() -> new RuntimeException("Mascota no encontrada"));

        Consulta nueva = consultaService.guardarRapida(fecha, apoderado, veterinario, mascota);
        return ResponseEntity.status(HttpStatus.CREATED).body(nueva);
    }

    // ---------- PUT (2) ----------

    @PutMapping("/{id}")
    public ResponseEntity<Consulta> actualizar(@PathVariable Long id, @RequestBody Consulta consulta) {
        return consultaService.actualizar(id, consulta)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}/reprogramar")
    public ResponseEntity<Consulta> reprogramar(
            @PathVariable Long id,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime nuevaFecha) {
        return consultaService.reprogramar(id, nuevaFecha)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    // ---------- DELETE (2) ----------

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        boolean eliminado = consultaService.eliminar(id);
        return eliminado ? ResponseEntity.noContent().build() : ResponseEntity.notFound().build();
    }

    @DeleteMapping("/mascota/{idMascota}")
    public ResponseEntity<Void> eliminarPorMascota(@PathVariable Long idMascota) {
        consultaService.eliminarPorMascota(idMascota);
        return ResponseEntity.noContent().build();
    }
}