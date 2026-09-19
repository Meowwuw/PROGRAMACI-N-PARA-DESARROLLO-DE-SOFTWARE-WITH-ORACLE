package com.canchavoley.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "cancha", schema = "renta_cancha") // Agregado el esquema para Postgres
public class Cancha {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cancha")
    private Long idCancha;

    @Column(name = "numero_cancha", nullable = false, unique = true)
    private Integer numeroCancha;

    public Cancha() {
    }

    public Cancha(Long idCancha, Integer numeroCancha) {
        this.idCancha = idCancha;
        this.numeroCancha = numeroCancha;
    }

    public Long getIdCancha() {
        return idCancha;
    }

    public void setIdCancha(Long idCancha) {
        this.idCancha = idCancha;
    }

    public Integer getNumeroCancha() {
        return numeroCancha;
    }

    public void setNumeroCancha(Integer numeroCancha) {
        this.numeroCancha = numeroCancha;
    }
}