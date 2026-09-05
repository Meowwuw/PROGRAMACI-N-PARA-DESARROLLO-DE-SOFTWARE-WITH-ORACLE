package com.canchavoley.backend.model;

public class Cancha {
    private Long id;
    private int numeroCancha;

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