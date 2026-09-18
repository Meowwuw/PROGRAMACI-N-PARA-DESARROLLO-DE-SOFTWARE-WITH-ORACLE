package com.canchavoley.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "cliente", schema = "renta_cancha")
public class Cliente {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_cliente")


    private Long id;

    private String nombre;
    private String apellido;
    private Integer telefono;
    private String dni;

    public Cliente(){}

    public Cliente(Long id, String nombre, String apellido, Integer telefono, String dni) {
        this.id=id;
        this.nombre=nombre;
        this.apellido=apellido;
        this.telefono=telefono;
        this.dni=dni;
    }

    public Long getId(){ return id;}

    public String getNombre(){ return nombre;}

    public String getApellido(){ return apellido;}

    public Integer getTelefono(){ return telefono;}

    public String getDni(){ return dni;}

    public void setNombre(){ this.nombre = nombre;}

    public void setApellido(){ this.apellido = apellido;}

    public void setTelefono(){ this.telefono = telefono;}

    public void setDni(){ this.dni = dni;}
}