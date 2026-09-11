package com.canchavoley.backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cancha", schema = "renta_cancha")
public class Cancha {
    @Id
    @Column (name = "id_cancha")
    private Long id;
    private int numeroCancha;

    public Cancha() {
    }

    public Cancha(Long id, int numeroCancha) {
        this.id = id;
        this.numeroCancha = numeroCancha;
    }

    public Long getId() {
        return id;
    }

    public int getNumeroCancha() {
        return numeroCancha;
    }
}