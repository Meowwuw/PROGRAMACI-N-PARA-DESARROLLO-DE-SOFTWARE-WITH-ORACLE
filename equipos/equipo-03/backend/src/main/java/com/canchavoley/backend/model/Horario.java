package com.canchavoley.backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "horario", schema = "renta_cancha")
public class Horario {
    @Id
    @Column(name = "id_horario")
    private Long id;
    private int horario;

    public Horario() {
    }

    public Horario(Long id, int horario) {
        this.id = id;
        this.horario = horario;
    }

    public Long getId() {
        return id;
    }

    public int getHorario() {
        return horario;
    }
}