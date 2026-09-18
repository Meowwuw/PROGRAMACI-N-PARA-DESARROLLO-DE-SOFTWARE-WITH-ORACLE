package com.veterinaria_xime.backend.service;

import com.veterinaria_xime.backend.model.Dueno;
import com.veterinaria_xime.backend.repository.DuenoRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DuenoService {
    private final DuenoRepository duenoRepository;

    public DuenoService(DuenoRepository duenoRepository){
        this.duenoRepository = duenoRepository;
    }

    public List<Dueno> listar(){
        return duenoRepository.findAll();
    }
    public Dueno buscarPorId(Long id) {
        return duenoRepository.findById(id)
                .orElse(null);
    }
    public Dueno actualizar(long id, Dueno datos){
        Dueno dueno = duenoRepository.findById(id)
                .orElse(null);

        if (dueno == null){
            return null;
        }
        dueno.setNombre(datos.getNombre());
        dueno.setTelefono(datos.getTelefono());
        dueno.setDireccion(datos.getDireccion());

        return duenoRepository.save(dueno);
    }

    public Dueno guardar(Dueno producto) {
        return duenoRepository.save(producto);
    }

    public void eliminar (Long id){
        duenoRepository.deleteById(id);
    }


}
