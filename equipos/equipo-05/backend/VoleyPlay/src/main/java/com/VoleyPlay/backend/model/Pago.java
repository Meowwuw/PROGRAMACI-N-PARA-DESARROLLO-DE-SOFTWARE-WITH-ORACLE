package com.VoleyPlay.backend.model;

import jakarta.persistence.*;

import java.time.LocalDate;

@Entity
@Table(name = "pago", schema = "voley_playa")
public class Pago {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_pago")
    private Long id;

    @Column(name = "id_reserva")
    private Long idReserva;

    @Column(name = "fecha_pago")
    private LocalDate fechaPago;

    private Double monto;

    private String metodoPago;

    private String estado;

    public Pago() {
    }

    public Pago(Long id, Long idReserva, LocalDate fechaPago, Double monto, String metodoPago, String estado) {
        this.id = id;
        this.idReserva = idReserva;
        this.fechaPago = fechaPago;
        this.monto = monto;
        this.metodoPago = metodoPago;
        this.estado = estado;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getIdReserva() {
        return idReserva;
    }

    public void setIdReserva(Long idReserva) {
        this.idReserva = idReserva;
    }

    public LocalDate getFechaPago() {
        return fechaPago;
    }

    public void setFechaPago(LocalDate fechaPago) {
        this.fechaPago = fechaPago;
    }

    public Double getMonto() {
        return monto;
    }

    public void setMonto(Double monto) {
        this.monto = monto;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public void setMetodoPago(String metodoPago) {
        this.metodoPago = metodoPago;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
}