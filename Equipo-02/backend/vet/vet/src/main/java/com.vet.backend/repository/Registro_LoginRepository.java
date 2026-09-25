package com.vet.backend.repository;

import com.vet.backend.model.Registro_Login;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;

@Repository
public interface Registro_LoginRepository extends JpaRepository<Registro_Login, Integer> {

    /** Busqueda con filtros opcionales (los que sean null se ignoran).
     *  OJO: 'username' debe llegar ya en minusculas (lo hace el service). */
    @Query("""
           SELECT r FROM Registro_Login r
           WHERE (:idUsuario IS NULL OR r.idUsuario = :idUsuario)
             AND (:username IS NULL OR LOWER(r.usernameIntentado) = :username)
             AND (:exito IS NULL OR r.exito = :exito)
           """)
    Page<Registro_Login> buscar(@Param("idUsuario") Integer idUsuario,
                                @Param("username") String username,
                                @Param("exito") Boolean exito,
                                Pageable pageable);

    /** Util para bloquear cuentas: intentos fallidos recientes de un username. */
    long countByUsernameIntentadoIgnoreCaseAndExitoFalseAndFechaHoraAfter(
            String username, LocalDateTime desde);
}