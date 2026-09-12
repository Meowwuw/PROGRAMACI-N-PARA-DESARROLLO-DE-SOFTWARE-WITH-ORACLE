package com.vet.backend.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "consulta", schema = "a_veterinaria")
public class Consulta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_consulta")
    private Long id;

    @Column(name = "fecha_con", nullable = false)
    private LocalDateTime fechaCon;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_apoderado", nullable = false)
    private Apoderado apoderado;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_veterinario", nullable = false)
    private Veterinario veterinario;

    public Consulta() {
    }

    public Consulta(LocalDateTime fechaCon, Apoderado apoderado, Veterinario veterinario) {
        this.fechaCon = fechaCon;
        this.apoderado = apoderado;
        this.veterinario = veterinario;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public LocalDateTime getFechaCon() {
        return fechaCon;
    }

    public void setFechaCon(LocalDateTime fechaCon) {
        this.fechaCon = fechaCon;
    }

    public Apoderado getApoderado() {
        return apoderado;
    }

    public void setApoderado(Apoderado apoderado) {
        this.apoderado = apoderado;
    }

    public Veterinario getVeterinario() {
        return veterinario;
    }

    public void setVeterinario(Veterinario veterinario) {
        this.veterinario = veterinario;
    }

    @Override
    public String toString() {
        return "Consulta{" +
                "id=" + id +
                ", fechaCon=" + fechaCon +
                '}';
    }
}