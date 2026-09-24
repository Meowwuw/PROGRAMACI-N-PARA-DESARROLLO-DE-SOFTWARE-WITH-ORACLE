package com.perfumeria.backend.repository;

import com.perfumeria.backend.model.PedidoEnvio;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PedidoEnvioRepository extends JpaRepository<PedidoEnvio, Long> {
}
