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
    public Producto(Long ia, String nombre, String telefono, String direccion){
        this.id = id;
        this.nombre = nombre;
        this.telefono = telefono;
        this.direccion = direccion;
    }

    public Long getId(){
        return id;
    }
    public String getNombre(){
        return nombre;
    }
    public  String getTelefono(){
        return telefono;
    }
    public  String getDireccion(){
        return direccion;
    }
}
