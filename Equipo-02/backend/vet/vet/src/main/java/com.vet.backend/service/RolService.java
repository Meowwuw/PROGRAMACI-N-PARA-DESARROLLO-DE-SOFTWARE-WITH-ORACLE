package com.vet.backend.service;

import com.vet.backend.dto.RolPatchRequest;
import com.vet.backend.dto.RolRequest;
import com.vet.backend.dto.RolResponse;
import com.vet.backend.model.Rol;
import com.vet.backend.repository.RolRepository;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import java.util.List;

@Service
public class RolService {

    private final RolRepository repository;

    public RolService(RolRepository repository) {
        this.repository = repository;
    }

    @Transactional(readOnly = true)
    public List<RolResponse> listar() {
        return repository.findAll().stream().map(RolResponse::from).toList();
    }

    @Transactional(readOnly = true)
    public RolResponse obtenerPorId(Integer id) {
        return RolResponse.from(buscarOFallar(id));
    }

    @Transactional(readOnly = true)
    public RolResponse obtenerPorNombre(String nombre) {
        return repository.findByNombreRolIgnoreCase(nombre.trim())
                .map(RolResponse::from)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND,
                        "Rol no encontrado: " + nombre));
    }

    @Transactional(readOnly = true)
    public boolean existe(Integer id) {
        return repository.existsById(id);
    }

    @Transactional
    public RolResponse crear(RolRequest req) {
        String nombre = normalizar(req.nombreRol());
        if (repository.existsByNombreRolIgnoreCase(nombre)) throw duplicado(nombre);
        return RolResponse.from(repository.save(new Rol(nombre)));
    }

    /** PUT: reemplaza el nombre del rol. */
    @Transactional
    public RolResponse actualizar(Integer id, RolRequest req) {
        Rol rol = buscarOFallar(id);
        String nombre = normalizar(req.nombreRol());
        if (repository.existsByNombreRolIgnoreCaseAndIdRolNot(nombre, id)) throw duplicado(nombre);
        rol.setNombreRol(nombre);
        return RolResponse.from(repository.save(rol));
    }

    /** PATCH: solo cambia lo que venga no nulo. */
    @Transactional
    public RolResponse actualizarParcial(Integer id, RolPatchRequest req) {
        Rol rol = buscarOFallar(id);
        if (req.nombreRol() != null && !req.nombreRol().isBlank()) {
            String nombre = normalizar(req.nombreRol());
            if (repository.existsByNombreRolIgnoreCaseAndIdRolNot(nombre, id)) throw duplicado(nombre);
            rol.setNombreRol(nombre);
        }
        return RolResponse.from(repository.save(rol));
    }

    @Transactional
    public void eliminar(Integer id) {
        Rol rol = buscarOFallar(id);
        try {
            repository.delete(rol);
            repository.flush(); // fuerza el DELETE aqui para poder capturar el error de FK
        } catch (DataIntegrityViolationException e) {
            throw new ResponseStatusException(HttpStatus.CONFLICT,
                    "No se puede eliminar el rol '" + rol.getNombreRol()
                            + "' porque hay usuarios que lo usan");
        }
    }

    // ---------- helpers ----------

    /** Guarda los nombres en minuscula, como en tu script (admin, veterinario...). */
    private String normalizar(String nombre) {
        return nombre.trim().toLowerCase();
    }

    private Rol buscarOFallar(Integer id) {
        return repository.findById(id).orElseThrow(() ->
                new ResponseStatusException(HttpStatus.NOT_FOUND, "Rol no encontrado: " + id));
    }

    private ResponseStatusException duplicado(String nombre) {
        return new ResponseStatusException(HttpStatus.CONFLICT,
                "Ya existe un rol con el nombre: " + nombre);
    }
}