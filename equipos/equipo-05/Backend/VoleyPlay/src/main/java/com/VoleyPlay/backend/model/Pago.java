package com.VoleyPlay.backend.model;

public class Pago {

    private Long id;
    private Long idReserva;
    private String fechaPago;
    private double monto;
    private String metodoPago;
    private String estado;

    public Pago(Long id, Long idReserva, String fechaPago, double monto, String metodoPago, String estado) {
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

    public Long getIdReserva() {
        return idReserva;
    }

    public String getFechaPago() {
        return fechaPago;
    }

    public double getMonto() {
        return monto;
    }

    public String getMetodoPago() {
        return metodoPago;
    }

    public String getEstado() {
        return estado;
    }
}