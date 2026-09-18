package com.veterinaria_xime.backend.controller;

import com.veterinaria_xime.backend.model.Dueno;
import com.veterinaria_xime.backend.service.DuenoService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/duenos")
public class DuenoController {

    private final DuenoService duenoService;

    public DuenoController(DuenoService duenoService) {
        this.duenoService = duenoService;
    }

    @GetMapping
    public List<Dueno> listar(){
        return duenoService.listar();
    }

    @GetMapping("/{id}")
    public Dueno buscarPorId(@PathVariable Long id) {
        return duenoService.buscarPorId(id);
    }

    @PostMapping
    public Dueno guardar(@RequestBody Dueno dueno) {
        return duenoService.guardar(dueno);
    }
    @PutMapping("/{id}")
    public Dueno actualizar(
            @PathVariable Long id,
            @RequestBody Dueno dueno){
        return duenoService.actualizar(id, dueno);
    }

    @DeleteMapping("/{id}")
    public  void eliminar(@PathVariable long id){
        duenoService.eliminar(id);
    }


}




