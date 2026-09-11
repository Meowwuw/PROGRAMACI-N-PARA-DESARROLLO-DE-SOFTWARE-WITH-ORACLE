package com.VoleyPlay.backend.model;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;

/*@Entity
@Table(name = "producto", schema = "michistore")*/
public class Producto {

    /*
    @id
    @Column(name ="id_producto")

    private Long id;
    */


    private Long id;
    private String nombre;
    private Double precio;
    private String categoria;

    public Producto (long id, String nombre, Double precio, String categoria){
        this.id=id;
        this.nombre=nombre;
        this.precio=precio;
        this.categoria=categoria;

    }

    public Long getId(){
        return id;
    }

    public String getNombre(){
        return  nombre;
    }

    public Double getPrecio(){
        return precio;
    }

    public String getCategoria(){
        return categoria;
    }
}
