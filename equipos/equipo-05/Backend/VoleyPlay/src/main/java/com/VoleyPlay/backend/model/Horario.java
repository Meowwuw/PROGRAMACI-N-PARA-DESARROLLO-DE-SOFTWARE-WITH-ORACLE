package com.VoleyPlay.backend.model;

public class Horario {

    private Long id;
    private String horaInicio;
    private String horaFin;
    private double precio;

    public Horario(Long id, String horaInicio, String horaFin, double precio) {
        this.id = id;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.precio = precio;
    }

    public Long getId() {
        return id;
    }

    public String getHoraInicio() {
        return horaInicio;
    }

    public String getHoraFin() {
        return horaFin;
    }

    public double getPrecio() {
        return precio;
    }
}