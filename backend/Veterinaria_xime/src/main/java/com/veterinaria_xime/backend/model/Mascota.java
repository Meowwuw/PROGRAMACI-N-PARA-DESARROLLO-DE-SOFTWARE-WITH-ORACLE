package com.veterinaria_xime.backend.model;

public class Mascota {
    private Long id;
    private Double precio;
    private String nombre;
    private String catego;


    public Mascota(Long id, Double precio, String nombre, String catego) {
        this.id = id;
        this.precio = precio;
        this.nombre = nombre;
        this.catego=catego;
    }

    public Long getId(){
        return id;
    }

    public String getNombre(){
        return nombre;
    }

    public Double getPrecio(){
        return precio;
    }

    public String getCatego(){
        return catego;
    }
}

