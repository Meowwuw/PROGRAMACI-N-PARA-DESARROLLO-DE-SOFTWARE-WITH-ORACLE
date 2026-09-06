package com.VoleyPlay.backend.model;

public class Cancha {

    private Long id;
    private int numero;
    private String nombre;
    private String tipoSuperficie;
    private String estado;

    public Cancha(Long id, int numero, String nombre, String tipoSuperficie, String estado) {
        this.id = id;
        this.numero = numero;
        this.nombre = nombre;
        this.tipoSuperficie = tipoSuperficie;
        this.estado = estado;
    }

    public Long getId() {
        return id;
    }

    public int getNumero() {
        return numero;
    }

    public String getNombre() {
        return nombre;
    }

    public String getTipoSuperficie() {
        return tipoSuperficie;
    }

    public String getEstado() {
        return estado;
    }
}