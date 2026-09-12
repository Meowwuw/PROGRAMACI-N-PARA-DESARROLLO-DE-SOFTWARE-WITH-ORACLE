package com.Vet.backend.model;

import org.springframework.web.bind.annotation.GetMapping;

public class Producto {
    private Long id;
    private String nombre;
    private double precio;

    public Producto(){
    }
    public Producto (Long id, String nombre, Double precio){
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
    }
    public Long getId(){
        return id;
    }
    public String getNombre(){
        return nombre;
    }
    public double getPrecio(){
        return precio;
    }
}
