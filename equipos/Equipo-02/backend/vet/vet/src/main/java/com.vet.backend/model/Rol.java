package com.vet.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "rol", schema = "a_veterinaria")
public class Rol {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY) // SERIAL en PostgreSQL
    @Column(name = "id_rol")
    private Integer idRol;

    @Column(name = "nombre_rol", nullable = false, unique = true, length = 30)
    private String nombreRol;

    public Rol() {}

    public Rol(String nombreRol) {
        this.nombreRol = nombreRol;
    }

    public Integer getIdRol() { return idRol; }
    public void setIdRol(Integer idRol) { this.idRol = idRol; }
    public String getNombreRol() { return nombreRol; }
    public void setNombreRol(String nombreRol) { this.nombreRol = nombreRol; }
}