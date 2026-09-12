package com.canchavoley.backend.model;

public class Horario {
    private Long id;
    private String hora;
    private double precio;

    public Horario(Long id, String hora, double precio) {
        this.id = id;
        this.hora = hora;
        this.precio = precio;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getHora() {
        return hora;
    }

    public void setHora(String hora) {
        this.hora = hora;
    }

    public double getPrecio() {
        return precio;
    }

    public void setPrecio(double precio) {
        this.precio = precio;
    }
}