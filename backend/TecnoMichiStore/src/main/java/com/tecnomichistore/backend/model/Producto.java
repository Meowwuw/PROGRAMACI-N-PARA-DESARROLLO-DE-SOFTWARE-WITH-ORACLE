package com.tecnomichistore.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "producto", schema = "michistore")
public class Producto {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
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

    public void setNombre(String nombre){
        this.nombre = nombre;
    }
    public void setCategoria(String categoria){
        this.categoria = categoria;
    }
    public void setPrecio(Double precio){
        this.precio = precio;
    }
    public void setStock(Integer stock){
        this.stock = stock;
    }


}



