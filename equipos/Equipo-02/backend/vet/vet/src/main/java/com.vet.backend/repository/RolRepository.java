package com.vet.backend.repository;

import com.vet.backend.model.Rol;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RolRepository extends JpaRepository<Rol, Integer> {

    Optional<Rol> findByNombreRolIgnoreCase(String nombreRol);

    boolean existsByNombreRolIgnoreCase(String nombreRol);

    /** Para validar duplicados al actualizar (ignora el propio registro). */
    boolean existsByNombreRolIgnoreCaseAndIdRolNot(String nombreRol, Integer idRol);
}