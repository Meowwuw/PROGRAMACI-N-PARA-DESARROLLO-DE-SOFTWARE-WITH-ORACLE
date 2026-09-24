package com.perfumeria.backend.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "perfume", schema = "public")
public class Perfume {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_perfume")
    private Long id;

    @Column(name = "id_marca")
    private Long idMarca;

    private String nombre;
    private String genero;
    private String concentracion;
    private Integer mililitros;
    private BigDecimal precio;
    private Integer stock;

    public Perfume() {
    }

    public Perfume(Long id, Long idMarca, String nombre, String genero, String concentracion,
                   Integer mililitros, BigDecimal precio, Integer stock) {
        this.id = id;
        this.idMarca = idMarca;
        this.nombre = nombre;
        this.genero = genero;
        this.concentracion = concentracion;
        this.mililitros = mililitros;
        this.precio = precio;
        this.stock = stock;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdMarca() {
        return idMarca;
    }

    public void setIdMarca(Long idMarca) {
        this.idMarca = idMarca;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getConcentracion() {
        return concentracion;
    }

    public void setConcentracion(String concentracion) {
        this.concentracion = concentracion;
    }

    public Integer getMililitros() {
        return mililitros;
    }

    public void setMililitros(Integer mililitros) {
        this.mililitros = mililitros;
    }

    public BigDecimal getPrecio() {
        return precio;
    }

    public void setPrecio(BigDecimal precio) {
        this.precio = precio;
    }

    public Integer getStock() {
        return stock;
    }

    public void setStock(Integer stock) {
        this.stock = stock;
    }
}