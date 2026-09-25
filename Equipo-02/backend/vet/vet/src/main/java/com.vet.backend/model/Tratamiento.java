package com.vet.backend.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "tratamiento", schema = "a_veterinaria")
public class Tratamiento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_tratamiento")
    private Long id;

    @Column(name = "tipo_tratamiento", length = 100, nullable = false)
    private String tipoTratamiento;

    @Column(name = "fecha_ini", nullable = false)
    private LocalDate fechaIni;

    @Column(name = "fecha_fin")
    private LocalDate fechaFin;

    @Column(name = "id_consulta", nullable = false)
    private Long idConsulta;

    public Tratamiento() {
    }

    public Tratamiento(String tipoTratamiento, LocalDate fechaIni, LocalDate fechaFin, Long idConsulta) {
        this.tipoTratamiento = tipoTratamiento;
        this.fechaIni = fechaIni;
        this.fechaFin = fechaFin;
        this.idConsulta = idConsulta;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTipoTratamiento() {
        return tipoTratamiento;
    }

    public void setTipoTratamiento(String tipoTratamiento) {
        this.tipoTratamiento = tipoTratamiento;
    }

    public LocalDate getFechaIni() {
        return fechaIni;
    }

    public void setFechaIni(LocalDate fechaIni) {
        this.fechaIni = fechaIni;
    }

    public LocalDate getFechaFin() {
        return fechaFin;
    }

    public void setFechaFin(LocalDate fechaFin) {
        this.fechaFin = fechaFin;
    }

    public Long getIdConsulta() {
        return idConsulta;
    }

    public void setIdConsulta(Long idConsulta) {
        this.idConsulta = idConsulta;
    }

    @Override
    public String toString() {
        return "Tratamiento{" +
                "id=" + id +
                ", tipoTratamiento='" + tipoTratamiento + '\'' +
                ", fechaIni=" + fechaIni +
                ", fechaFin=" + fechaFin +
                ", idConsulta=" + idConsulta +
                '}';
    }
}