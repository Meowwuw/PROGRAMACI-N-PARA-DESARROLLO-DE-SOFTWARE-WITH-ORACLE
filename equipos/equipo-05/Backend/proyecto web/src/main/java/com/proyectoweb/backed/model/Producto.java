package com.proyectoweb.backed.model;

public class Producto {
    private Long id;
    private String nombre;
    private Double precio;
    private String categoria;
    public Producto(Long id, String nombre, Double precio, String categoria) {
        this.id = id;
        this.nombre = nombre;
        this.precio = precio;
        this.categoria=categoria;
    }

    public  Long getId(){
        return id;
    }
    public String getNombre(){
        return  nombre;
    }
    public Double getPrecio()
    { return  precio; }

    public String getCategoria(){
        return  categoria;}
}






