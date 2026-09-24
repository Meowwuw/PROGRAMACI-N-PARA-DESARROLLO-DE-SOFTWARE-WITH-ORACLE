package com.perfumeria.backend.model;

import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "recepcion_carga", schema = "a_perfumeria")
public class RecepcionCarga {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_recepcion")
    private Long id;

    @Column(name = "id_perfume")
    private Long idPerfume;

    @Column(name = "numero_lote")
    private String numeroLote;

    @Column(name = "cantidad_recibida")
    private Integer cantidadRecibida;

    @Column(name = "fecha_recepcion")
    private LocalDate fechaRecepcion;

    public RecepcionCarga() {
    }

    public RecepcionCarga(Long id, Long idPerfume, String numeroLote, Integer cantidadRecibida, LocalDate fechaRecepcion) {
        this.id = id;
        this.idPerfume = idPerfume;
        this.numeroLote = numeroLote;
        this.cantidadRecibida = cantidadRecibida;
        this.fechaRecepcion = fechaRecepcion;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdPerfume() {
        return idPerfume;
    }

    public void setIdPerfume(Long idPerfume) {
        this.idPerfume = idPerfume;
    }

    public String getNumeroLote() {
        return numeroLote;
    }

    public void setNumeroLote(String numeroLote) {
        this.numeroLote = numeroLote;
    }

    public Integer getCantidadRecibida() {
        return cantidadRecibida;
    }

    public void setCantidadRecibida(Integer cantidadRecibida) {
        this.cantidadRecibida = cantidadRecibida;
    }

    public LocalDate getFechaRecepcion() {
        return fechaRecepcion;
    }

    public void setFechaRecepcion(LocalDate fechaRecepcion) {
        this.fechaRecepcion = fechaRecepcion;
    }
}
