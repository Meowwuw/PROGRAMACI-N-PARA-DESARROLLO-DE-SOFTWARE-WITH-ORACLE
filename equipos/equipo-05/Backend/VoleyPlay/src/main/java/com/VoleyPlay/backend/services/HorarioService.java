package com.VoleyPlay.backend.services;

import com.VoleyPlay.backend.model.Horario;
import com.VoleyPlay.backend.Repository.HorarioRepository;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class HorarioService {
    private final HorarioRepository horarioRepository;

    public HorarioService(HorarioRepository horarioRepository){
        this.horarioRepository=horarioRepository;
    }

    public List<Horario> listar() {
        return horarioRepository.findAll();
    }

    public Horario guardar(Horario horario) {
        return horarioRepository.save(horario);
    }

    public Horario actualizar(Long id, Horario datos) {
        Horario horario = horarioRepository.findById(id)
                .orElse(null);

        if (horario == null) {
            return null;
        }

        horario.setHoraInicio(datos.getHoraInicio());
        horario.setHoraFin(datos.getHoraFin());
        horario.setPrecio(datos.getPrecio());

        return horarioRepository.save(horario);

    }

    public void eliminar(Long id) {
        horarioRepository.deleteById(id);

    }

}