package com.veterinaria_xime.backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "dueno" , schema = "public")
public class Dueno{
    @Id
    @Column(name="id_dueno")
    private Long id;

    private String nombre;
    private String telefono;
    private String direccion;

    public Dueno(){
    }

        public Dueno(Long id, String direccion, String nombre, String telefono) {
            this.id = id;
            this.direccion = direccion;
            this.nombre = nombre;
            this.telefono=telefono;
        }

        public Long getId(){
            return id;
        }

        public String getNombre(){
            return nombre;
        }

        public String getDireccion(){
            return direccion;
        }

        public String getTelefono(){
            return telefono;
        }
    }


