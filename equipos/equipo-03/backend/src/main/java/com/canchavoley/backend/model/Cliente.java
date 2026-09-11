package com.canchavoley.backend.model;

/*
public class Cliente {
    private Long id;
    private String nombre;
    private String apellido;
    private Integer telefono;

    public Cliente(Long id, String nombre, String apellido, Integer telefono){
        this.id=id;
        this.nombre=nombre;
        this.apellido=apellido;
        this.telefono=telefono;
    }

    public Long getId(){ return id;}

    public String getNombre(){ return nombre;}

    public String getApellido(){ return apellido;}

    public Integer getTelefono(){ return telefono;}
}
*/

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "cliente", schema = "renta_cancha")
public class Cliente {
    @Id
    @Column(name="id_cliente")


    private Long id;

    private String nombre;
    private String apellido;
    private Integer telefono;

    public Cliente(){}

    public Cliente(Long id, String nombre, String apellido, Integer telefono) {
        this.id=id;
        this.nombre=nombre;
        this.apellido=apellido;
        this.telefono=telefono;
    }

    public Long getId(){ return id;}

    public String getNombre(){ return nombre;}

    public String getApellido(){ return apellido;}

    public Integer getTelefono(){ return telefono;}
}