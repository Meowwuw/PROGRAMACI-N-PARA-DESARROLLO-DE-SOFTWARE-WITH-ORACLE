package com.VoleyPlay.backend.controller;

import com.VoleyPlay.backend.model.Horario;
<<<<<<< HEAD
import com.VoleyPlay.backend.services.HorarioService; // Corregido: 'services' en plural
=======
import com.VoleyPlay.backend.repository.HorarioRepository;

>>>>>>> 95c09642a97319db6f1676f5ef83078e7076ff80
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/horarios")
@CrossOrigin("*")
public class HorarioController {

    @Autowired
    private HorarioService horarioService;

    @GetMapping
    public List<Horario> obtenerTodos() {
        return horarioService.listar(); // Corregido: método listar()
    }

    @PostMapping
    public Horario guardar(@RequestBody Horario horario) {
        return horarioService.guardar(horario);
    }

    @PutMapping("/{id}")
    public Horario actualizar(@PathVariable Long id, @RequestBody Horario horario) {
        return horarioService.actualizar(id, horario);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        horarioService.eliminar(id);
    }
}