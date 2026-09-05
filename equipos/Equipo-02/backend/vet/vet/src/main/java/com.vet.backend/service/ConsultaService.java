```java id="k8m3pz"
package com.vet.backend.service;

import com.vet.backend.model.Consulta;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class ConsultaService {

    private final List<Consulta> consultas = new ArrayList<>();

    // Listar todas las consultas
    public List<Consulta> listarConsultas() {
        return consultas;
    }

    // Buscar una consulta por ID
    public Consulta obtenerConsulta(Long id) {

        for (Consulta consulta : consultas) {
            if (id.equals(consulta.getIdConsulta())) {
                return consulta;
            }
        }

        return null;
    }

    // Crear una consulta
    public Consulta crearConsulta(Consulta consulta) {
        consultas.add(consulta);
        return consulta;
    }

    // Actualizar una consulta
    public Consulta actualizarConsulta(Long id, Consulta consultaActualizada) {

        for (Consulta consulta : consultas) {

            if (id.equals(consulta.getIdConsulta())) {

                consulta.setFechaCon(consultaActualizada.getFechaCon());
                consulta.setIdApoderado(consultaActualizada.getIdApoderado());
                consulta.setIdVeterinario(consultaActualizada.getIdVeterinario());

                return consulta;
            }
        }

        return null;
    }

    // Eliminar una consulta
    public boolean eliminarConsulta(Long id) {

        return consultas.removeIf(
                consulta -> id.equals(consulta.getIdConsulta())
        );
    }
}
```
