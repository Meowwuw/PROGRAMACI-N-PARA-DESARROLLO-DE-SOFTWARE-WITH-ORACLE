package com.tecnomichistore.backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "producto", schema = "michistore")
public class Producto {
    @Id
    @Column(name="id_producto")
    private Long id;

    private String nombre;
    private String categoria;
    private Double precio;
    private Integer stock;

    public Producto (){
    }

    public Producto (Long id, String nombre,String categoria, Double precio, Integer stock ){
        this.id=id;
        this.nombre=nombre;
        this.categoria=categoria;
        this.precio=precio;
        this.stock=stock;
    }

    public Long getId(){
        return id;
    }
    public String getNombre(){
        return nombre;
    }
    public String getCategoria(){
        return categoria;
    }
    public Double getPrecio(){
        return precio;
    }
    public Integer getStock(){
        return stock;
    }
}



