package com.VoleyPlay.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "cancha", schema = "voley_playa")
public class Cancha {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cancha")
    private Long id;

    private int numero;

    private String nombre;

    private String tipoSuperficie;

    private String estado;

    public Cancha() {
    }

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

    public void setId(Long id) {
        this.id = id;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
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