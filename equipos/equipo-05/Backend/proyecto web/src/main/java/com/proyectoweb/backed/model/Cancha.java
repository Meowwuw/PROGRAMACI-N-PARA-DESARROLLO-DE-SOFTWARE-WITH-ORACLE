package com.proyectoweb.backed.model;

public class Cancha {
    private Long idCancha;
    private Integer numero;
    private String nombre;
    private String tipoSuperficie;
    private String estado;

    public Cancha(Long idCancha, Integer numero, String nombre, String tipoSuperficie, String estado) {
        this.idCancha = idCancha;
        this.numero = numero;
        this.nombre = nombre;
        this.tipoSuperficie = tipoSuperficie;
        this.estado = estado;
    }

    public Long getIdCancha() {
        return idCancha;
    }

    public void setIdCancha(Long idCancha) {
        this.idCancha = idCancha;
    }

    public Integer getNumero() {
        return numero;
    }

    public void setNumero(Integer numero) {
        this.numero = numero;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getTipoSuperficie() {
        return tipoSuperficie;
    }

    public void setTipoSuperficie(String tipoSuperficie) {
        this.tipoSuperficie = tipoSuperficie;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}