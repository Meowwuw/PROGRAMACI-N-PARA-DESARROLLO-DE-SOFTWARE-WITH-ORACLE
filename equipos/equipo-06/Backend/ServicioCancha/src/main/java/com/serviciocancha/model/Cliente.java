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

    // --- NUEVOS CAMPOS ---
    @Column(nullable = false, unique = true, length = 100)
    private String email;

    @Column(nullable = false, length = 255)
    private String password;

    // Constructor vacío (obligatorio para JPA)
    public Cliente() {}

    // Constructor completo actualizado
    public Cliente(String nombre, String telefono, String dni, String email, String password) {
        this.nombre = nombre;
        this.telefono = telefono;
        this.dni = dni;
        this.email = email;
        this.password = password;
    }

    // --- GETTERS Y SETTERS EXISTENTES ---
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public String getDni() { return dni; }
    public void setDni(String dni) { this.dni = dni; }

    // --- NUEVOS GETTERS Y SETTERS ---
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}