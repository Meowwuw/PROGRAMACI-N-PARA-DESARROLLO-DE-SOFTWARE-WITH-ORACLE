package com.VoleyPlay.backend.model;


import jakarta.persistence.*;
import org.springframework.stereotype.Service;

@Entity
@Table(name = "cliente", schema = "voley_playa")
public class Cliente {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name="id_cliente")
    private Long id;

    private String nombre;
    private String apellido;
    private String dni;
    private String telefono;
    private String email;

    public Cliente(){
    }

    public Cliente (Long id, String nombre, String apellido, String dni, String telefono, String email){
        this.id=id;
        this.nombre=nombre;
        this.apellido=apellido;
        this.dni=dni;
        this.telefono=telefono;
        this.email=email;
    }

    public Long getId(){
        return id;
    }
    public String getNombre(){
        return nombre;
    }
    public String getApellido(){
        return apellido;
    }
    public String getDni(){
        return dni;
    }
    public String getTelefono(){
        return telefono;
    }
    public String getEmail(){
        return email;
    }

    public void setNombre(String nombre){
        this.nombre=nombre;
    }
    public void setApellido(String apellido){
        this.apellido=apellido;
    }
    public void setDni(String dni){
        this.dni=dni;
    }
    public void setTelefono(String telefono){
        this.telefono=telefono;
    }
    public void setEmail(String email){
        this.email=email;
    }

}

