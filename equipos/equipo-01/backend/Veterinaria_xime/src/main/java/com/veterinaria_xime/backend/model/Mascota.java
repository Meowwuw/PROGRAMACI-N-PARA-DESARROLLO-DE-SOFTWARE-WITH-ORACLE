package com.veterinaria_xime.backend.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDate;

@Entity
@Table(name = "mascotas", schema = "public")
public class Mascota {

    @Id
    @Column(name = "id_mascota")
    private Long id;

    @Column(name = "nombre")
    private String nombre;

    @Column(name = "id_dueno")
    private Long idDueno;

    @Column(name = "id_raza")
    private Long idRaza;

    @Column(name = "fecha_nacimiento")
    private LocalDate fechaNacimiento;

    public Mascota() {
    }

    public Long getId() { return id; }
    public String getNombre() { return nombre; }
    public Long getIdDueno() { return idDueno; }
    public Long getIdRaza() { return idRaza; }
    public LocalDate getFechaNacimiento() { return fechaNacimiento; }

    public void setId(Long id) { this.id = id; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public void setIdDueno(Long idDueno) { this.idDueno = idDueno; }
    public void setIdRaza(Long idRaza) { this.idRaza = idRaza; }
    public void setFechaNacimiento(LocalDate fechaNacimiento) { this.fechaNacimiento = fechaNacimiento; }
}