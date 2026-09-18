package com.VoleyPlay.backend.model;

import jakarta.persistence.*;

@Entity
@Table(name = "horario")
public class Horario {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "hora_inicio")
    private String horaInicio;

    @Column(name = "hora_fin")
    private String horaFin;

    private double precio;

    public Horario() {}

    public Horario(Long id, String horaInicio, String horaFin, double precio) {
        this.id = id;
        this.horaInicio = horaInicio;
        this.horaFin = horaFin;
        this.precio = precio;
    }

    // Getters y Setters obligatorios
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getHoraInicio() { return horaInicio; }
    public void setHoraInicio(String horaInicio) { this.horaInicio = horaInicio; }

    public String getHoraFin() { return horaFin; }
    public void setHoraFin(String horaFin) { this.horaFin = horaFin; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }
}