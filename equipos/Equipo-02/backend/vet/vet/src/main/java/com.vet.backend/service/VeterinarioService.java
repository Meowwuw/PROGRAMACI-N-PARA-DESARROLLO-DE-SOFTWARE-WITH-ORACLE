package com.vet.backend.service;

import com.vet.backend.model.Veterinario;
import com.vet.backend.repository.VeterinarioRepository;
import jakarta.persistence.EntityNotFoundException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VeterinarioService {

    @Autowired
    private VeterinarioRepository veterinarioRepository;

    // ---------- GET ----------

    public List<Veterinario> listarTodos() {
        return veterinarioRepository.findAll();
    }

    public Veterinario obtenerPorId(Long id) {
        return veterinarioRepository.findById(id)
                .orElseThrow(() -> new EntityNotFoundException("Veterinario no encontrado con id: " + id));
    }

    public List<Veterinario> obtenerPorEspecialidad(String especialidad) {
        return veterinarioRepository.findByEspecialidadIgnoreCase(especialidad);
    }

    public Veterinario obtenerPorTelefono(String telefono) {
        return veterinarioRepository.findByTelefono(telefono)
                .orElseThrow(() -> new EntityNotFoundException("Veterinario no encontrado con telefono: " + telefono));
    }

    public List<Veterinario> buscarPorNombre(String nombre) {
        return veterinarioRepository.findByNombreContainingIgnoreCase(nombre);
    }

    // ---------- POST ----------

    public Veterinario crear(Veterinario veterinario) {
        veterinario.setId(null);
        return veterinarioRepository.save(veterinario);
    }

    public List<Veterinario> crearEnLote(List<Veterinario> veterinarios) {
        veterinarios.forEach(v -> v.setId(null));
        return veterinarioRepository.saveAll(veterinarios);
    }

    // ---------- PUT ----------

    public Veterinario actualizar(Long id, Veterinario datosActualizados) {
        Veterinario existente = obtenerPorId(id);
        existente.setNombre(datosActualizados.getNombre());
        existente.setEspecialidad(datosActualizados.getEspecialidad());
        existente.setTelefono(datosActualizados.getTelefono());
        return veterinarioRepository.save(existente);
    }

    public Veterinario actualizarTelefono(Long id, String telefono) {
        Veterinario existente = obtenerPorId(id);
        existente.setTelefono(telefono);
        return veterinarioRepository.save(existente);
    }

    // ---------- DELETE ----------

    public void eliminarPorId(Long id) {
        if (!veterinarioRepository.existsById(id)) {
            throw new EntityNotFoundException("Veterinario no encontrado con id: " + id);
        }
        veterinarioRepository.deleteById(id);
    }

    public int eliminarPorEspecialidad(String especialidad) {
        return veterinarioRepository.deleteByEspecialidad(especialidad);
    }
}