package com.serviciocancha.model;
import jakarta.persistence.*;

@Entity
@Table(name = "cliente")

public class Cliente {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 100)
    private String nombre;

    @Column(nullable = false, length = 20)
    private String telefono;

    @Column(nullable = false, unique = true, length = 15)
    private String dni;

    public Cliente() {}

    public Cliente(String nombre, String telefono, String dni) {
        this.nombre = nombre;
        this.telefono = telefono;
        this.dni = dni;
    }

    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }
}
