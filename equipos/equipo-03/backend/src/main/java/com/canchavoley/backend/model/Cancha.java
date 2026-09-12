package com.canchavoley.backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cancha", schema = "renta_cancha")
public class Cancha {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cancha")
    private Integer id;

    private int numeroCancha;

    public Cancha() {
    }

    public Cancha(Integer id, int numeroCancha) {
        this.id = id;
        this.numeroCancha = numeroCancha;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public int getNumeroCancha() {
        return numeroCancha;
    }

    public void setNumeroCancha(int numeroCancha) {
        this.numeroCancha = numeroCancha;
    }
}