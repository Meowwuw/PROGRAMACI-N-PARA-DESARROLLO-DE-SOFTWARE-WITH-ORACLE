package com.Vet.backend.repository;

import com.Vet.backend.model.Usuario;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UsuarioRepository extends JpaRepository<Usuario, Long> {

    // Método para buscar usuario por correo electrónico
    Optional<Usuario> findByEmail(String email);

    // Método para verificar si el correo ya existe
    boolean existsByEmail(String email);
}