package com.perfumeria.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "marca", schema = "public")
public class Marca {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_marca")
    private Long id;

    private String nombre;

    @Column(name = "pais_origen")
    private String paisOrigen;

    private String descripcion;

    public Marca() {
    }

    public Marca(Long id, String nombre, String paisOrigen, String descripcion) {
        this.id = id;
        this.nombre = nombre;
        this.paisOrigen = paisOrigen;
        this.descripcion = descripcion;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getPaisOrigen() {
        return paisOrigen;
    }

    public void setPaisOrigen(String paisOrigen) {
        this.paisOrigen = paisOrigen;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }
}