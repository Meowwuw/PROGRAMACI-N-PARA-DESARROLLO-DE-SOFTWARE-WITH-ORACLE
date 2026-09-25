package com.vet.backend.repository;

import com.vet.backend.model.Veterinario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VeterinarioRepository extends JpaRepository<Veterinario, Long> {

    List<Veterinario> findByEspecialidadIgnoreCase(String especialidad);

    Optional<Veterinario> findByTelefono(String telefono);

    List<Veterinario> findByNombreContainingIgnoreCase(String nombre);

    @Modifying
    @Query("DELETE FROM Veterinario v WHERE v.especialidad = :especialidad")
    int deleteByEspecialidad(@Param("especialidad") String especialidad);
}