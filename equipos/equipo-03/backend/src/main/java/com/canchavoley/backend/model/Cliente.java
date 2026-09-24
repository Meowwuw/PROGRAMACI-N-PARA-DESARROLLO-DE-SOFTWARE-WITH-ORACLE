package com.canchavoley.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "cliente", schema = "renta_cancha")
public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_cliente")
    private Long idCliente;

    @Column(name = "telefono", nullable = false, length = 20)
    private String telefono;

    @Column(name = "nombre", nullable = false, length = 100)
    private String nombre;

    @Column(name = "apellido", nullable = false, length = 100)
    private String apellido;

    @Column(name = "dni", nullable = false, unique = true, length = 8)
    private String dni;

    public Cliente() {
    }

    public Cliente(Long idCliente, String telefono, String nombre, String apellido, String dni) {
        this.idCliente = idCliente;
        this.telefono = telefono;
        this.nombre = nombre;
        this.apellido = apellido;
        this.dni = dni;
    }

    public Long getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Long idCliente) {
        this.idCliente = idCliente;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }
}