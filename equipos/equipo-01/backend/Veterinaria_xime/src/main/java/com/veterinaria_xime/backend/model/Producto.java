package com.veterinaria_xime.backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "duenos", schema = "public")
public class Producto {
    @Id
    @Column(name = "id_dueno")
    private Long id;

    private String nombre;
    private String telefono;
    private String direccion;

    public Producto(){
    }

    public Producto(Long id, String nombre, String telefono, String direccion){
        this.id = id;
        this.nombre = nombre;
        this.telefono = telefono;
        this.direccion = direccion;
    }

    // --- GETTERS ---
    public Long getId(){
        return id;
    }
    public String getNombre(){
        return nombre;
    }
    public String getTelefono(){
        return telefono;
    }
    public String getDireccion(){
        return direccion;
    }

    // --- SETTERS (¡La clave para que Postman funcione!) ---
    public void setId(Long id) {
        this.id = id;
    }
    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }
    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }
}