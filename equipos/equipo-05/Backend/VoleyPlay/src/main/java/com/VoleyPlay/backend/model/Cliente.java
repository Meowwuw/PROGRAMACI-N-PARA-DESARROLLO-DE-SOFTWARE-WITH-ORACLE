package com.VoleyPlay.backend.model;

public class Cliente {

    private Long id;
    private String nombre;
    private String apellido;
    private String DNI;
    private String telefono;
    private String email;

    public Cliente(Long id, String nombre, String apellido, String DNI, String telefono, String email) {
        this.id = id;
        this.nombre = nombre;
        this.apellido = apellido;
        this.DNI = DNI;
        this.telefono = telefono;
        this.email = email;
    }

    public Long getId() {
        return id;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getDNI() {
        return DNI;
    }

    public String getTelefono() {
        return telefono;
    }

    public String getEmail() {
        return email;
    }
}
